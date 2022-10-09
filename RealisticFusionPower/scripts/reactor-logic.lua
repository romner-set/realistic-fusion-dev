local function print_log(str) game.print(str); log(str) end

-- #region --TODO TESTING CONSTANTS --
local boltzmann_constant = 1.380649e-23 --J/K
local k_per_ev = 11604.52500617
local joules_per_ev = 1.6021773e-19
local min_field_strength = 20e6/60 --J/t; same as ITER
local max_field_strength = 50e6/60 --J/t; ITER doesn't need anything because of superconductors afaik, but it'd probably just confuse people so...
local systems_consumption = 100e6/60 --J/t; same as ITER?
local max_divertor_strength = 750e6/60 --J/t
local tritium_atomic_mass = 3.016; local deuterium_atomic_mass = 2.014 --amu or g/mol
local avogadros_constant = 6.02214086e23
local amu_per_kg = avogadros_constant*1e3
local c = 299792458
local cs = c^2
local pm_amu = { --amu (g/mol); particle masses
    T = 3.01604928, D = 2.013553212745, He3 = 3.016029, He4 = 4.002603254
}
local pm = { --kg; particle masses
    T = pm_amu.T/amu_per_kg, D = pm_amu.D/amu_per_kg, He3 = pm_amu.He3/amu_per_kg,
    He4 = pm_amu.He4/amu_per_kg, n = 1.67492749804e-27, p = 1.67262192e-27
}
local reaction_energies = {               --J; seems to be slightly off (17.08MeV for D-T instead of 17.6 for example), but it seems to be at least 95% correct
    ["D-D_He3"] = (pm.D*2 - pm.He3-pm.n)*cs, --plus I can't find values for anything other than D-T anywhere so...
    ["D-D_T"] = (pm.D*2 - pm.T-pm.p)*cs,
    ["D-T"] = (pm.D+pm.T - pm.He4-pm.n)*cs,
    ["D-He3"] = (pm.D+pm.He3 - pm.He4-pm.p)*cs,

    ["T-T"] = (pm.T+pm.T - pm.He4-pm.n-pm.n)*cs,
    ["He3-He3"] = (pm.He3+pm.He3 - pm.He4-pm.p-pm.p)*cs,
    ["T-He3"] = (pm.T+pm.He3 - pm.He4-pm.n-pm.p)*cs,
}
local ml_per_unit = 25000/523
local atmosphere_density = 1.204 --kg/m^3, at STP


-- #endregion --

-- #region DATASETS --
rfp_datasets = require(".cross-section-data/datasets-reactivities") --global constants
rfp_dataset_sizes = {}
for k, v in pairs(rfp_datasets) do
    rfp_dataset_sizes[k] = table_size(v) --https://lua-api.factorio.com/latest/Libraries.html
    --log(k)

    for i, _v in ipairs(v) do --premultiply reactivities to reduce runtime cost
        rfp_datasets[k][i][2] = _v[2]*reaction_energies[k]
    end
end
-- #endregion --

-- #region FUNCTIONS --

-- modified binary search for finding the nearest match in a given dataset
function rfpower.binsearch(data, size, value)
    local nearest_down,mid,nearest_up = 1,0,size
    while nearest_down <= nearest_up do
        mid = math.floor((nearest_down+nearest_up)/2)
        local e = data[mid][1]

        if value < e then
            nearest_up = mid - 1
        elseif value > e then
            nearest_down = mid + 1
        else --exact match, not likely to happen
            return mid,mid
        end
    end

    if nearest_up == 0 then return 1,2 end
    if nearest_down >= size then return size-1,size end

    return nearest_down,nearest_up
end

-- estimates reactivity based on the two closest points in a dataset
function rfpower.estimate_r(network, dataset)
    local last_index = network.cached_reactivity[dataset]
    local target_energy = (network.plasma_temperature*1e6)/k_per_ev
    local data = rfp_datasets[dataset]
    --local dataset_size = rfp_dataset_sizes[dataset]
    local nearest_down,nearest_up = last_index,last_index+1

    if data[nearest_down][1] > target_energy then
        if nearest_down > 1 then
            if data[nearest_down-1][1] > target_energy then --data way off
                nearest_down,nearest_up = rfpower.binsearch(data, rfp_dataset_sizes[dataset], target_energy)
                last_index = nearest_down
                if nearest_down == nearest_up then return data[nearest_down][2] end
            else
                nearest_up = nearest_down
                nearest_down = nearest_down-1
                last_index = nearest_down
            end
        end
    elseif data[nearest_up][1] < target_energy then
        if nearest_down < rfp_dataset_sizes[dataset]-1 then
            if data[nearest_up+1][1] < target_energy then --data way off
                nearest_down,nearest_up = rfpower.binsearch(data, rfp_dataset_sizes[dataset], target_energy)
                last_index = nearest_down
                if nearest_down == nearest_up then return data[nearest_down][2] end
            else
                nearest_down = nearest_up
                nearest_up = nearest_up+1
                last_index = nearest_down
            end
        end
    else return data[nearest_up][2] end


    --estimate value at energy_ev by (mathematically) plotting a line between the two closest points
    local nearest_down_e = data[nearest_down][1]
    local nearest_down_sig = data[nearest_down][2]
    return ((target_energy - nearest_down_e)/(data[nearest_up][1] - nearest_down_e)) * (data[nearest_up][2] - nearest_down_sig) + nearest_down_sig
end

function rfpower.update_gui_bar(network, name, max, unit, value)
    if network.systems == "right" then
        value = value or network[name]
        for idx, v in pairs(network.guis.bars) do
            for gui_id, _v in pairs(v) do
                local new_name = name:gsub("_","-")
                if _v[new_name] and _v[new_name].valid then
                    _v[new_name].value = value/max
                    _v[new_name].parent["rf-"..new_name.."-value-frame"]["rf-"..new_name.."-value"].caption = string.sub(value, 1,6)..unit
                end
            end
        end
    end
end
-- #endregion --

-- #region MAIN FUNCTION --

return function(network, current_tick) --runs on_tick, per network
    if false then --TODO current_tick%20==0 then
        local dd_count = 0
        for _,e in pairs(network.heaters) do
            dd_count = dd_count + e.get_fluid_count("rf-deuterium")
        end
        print_log("dd: "..dd_count)
    end

    -- #region UPDATE PLASMA --
    local plasma_volume = network.reactor_volume
    local plasma_mass = network.total_plasma*plasma_volume*(0.18+0.27)/2
    for _,k in ipairs{"deuterium", "tritium", "helium_3"} do
        local old = network[k]
        if network.total_plasma <= 0.95 and network[k.."_input"] > 0 then
            network[k] = (network[k] + network[k.."_input"]/10)
        end
        if network[k] > 0 and network[k.."_removal"] > 0 then
            network[k] = network[k] - network[k.."_removal"]/10
        end

        if old ~= network[k] then
            if network[k] < 0 then network[k] = 0
            elseif network[k] > plasma_volume*0.95 then network[k] = plasma_volume*0.95 end
            rfpower.update_gui_bar(network, k, plasma_volume, "u")
            --network.plasma_temperature = network.plasma_temperature*(plasma_mass * 5920.5) --temp = energy/(mass*specific_heat)
        end
    end
    --log(network.total_plasma)
    -- #endregion --
    
    -- #region --TODO TESTING VARIABLES --
    network.total_plasma = (network.deuterium + network.tritium + network.helium_3)/plasma_volume
    --log(serpent.line{network.deuterium, network.tritium, network.helium_3})
    rfpower.update_gui_bar(network, "total_plasma", plasma_volume, "u", network.total_plasma*plasma_volume)
    local divertor_strength = max_divertor_strength*network.divertor_strength/100
    local max_particles = (1e20*plasma_volume)^2
    local energy_loss = 120/60  --J/t/K; completely arbitrary value, as setting it to something truly realistic would probably just make the reactors not produce any net energy
    -- #endregion --

    if network.total_plasma > 0 then
-------- #region SIMULATE REACTIONS --------
        local fusion_energy = 0

        if network.deuterium > 0 then
            local d_number_density   = network.deuterium * ml_per_unit * atmosphere_density*1e-3 / pm_amu.D   * avogadros_constant   / plasma_volume
            local t_number_density   = network.tritium   * ml_per_unit * atmosphere_density*1e-3 / pm_amu.T   * avogadros_constant   / plasma_volume
            local he3_number_density = network.helium_3  * ml_per_unit * atmosphere_density*1e-3 / pm_amu.He3 * avogadros_constant   / plasma_volume
            --log(serpent.line{d_number_density, t_number_density, he3_number_density})

            local dd_t_chance = rfpower.estimate_r(network, "D-D_T")*(d_number_density*d_number_density)
            local dd_he3_chance = rfpower.estimate_r(network, "D-D_He3")*(d_number_density*d_number_density)
            local dt_chance = rfpower.estimate_r(network, "D-T")*d_number_density*t_number_density
            local dhe3_chance = rfpower.estimate_r(network, "D-He3")*d_number_density*he3_number_density
            local tt_chance = rfpower.estimate_r(network, "T-T")*(t_number_density*t_number_density)
            local the3_chance = rfpower.estimate_r(network, "T-He3")*t_number_density*he3_number_density
            local he3he3_chance = rfpower.estimate_r(network, "He3-He3")*(he3_number_density*t_number_density)

            --log(serpent.block{dd_t_chance, dd_he3_chance, dt_chance, dhe3_chance, tt_chance, the3_chance, he3he3_chance})

            fusion_energy = plasma_volume*joules_per_ev*(
                  dd_t_chance   * reaction_energies["D-D_T"]
                + dd_he3_chance * reaction_energies["D-D_He3"]
                + dt_chance     * reaction_energies["D-T"]
                + dhe3_chance   * reaction_energies["D-He3"]
                + tt_chance     * reaction_energies["T-T"]
                + the3_chance   * reaction_energies["T-He3"]
                + he3he3_chance * reaction_energies["He3-He3"]
            )/60

            --local d_loss = (dd_t_chance + dd_he3_chance)*2 + (dt_chance + dhe3_chance)
            --local t_loss = tt_chance*2 + (dt_chance + the3_chance) - dd_t_chance
            --local he3_loss = he3he3_chance*2 + (dhe3_chance + the3_chance) - dd_he3_chance
            --if d_loss ~= d_loss or d_loss == 1/0 or d_loss == -1/0 then d_loss = 0 end
            --if t_loss ~= t_loss or t_loss == 1/0 or d_loss == -1/0 then t_loss = 0 end
            --if he3_loss ~= he3_loss or he3_loss == 1/0 or d_loss == -1/0 then he3_loss = 0 end

            --log(serpent.line{d_loss*2e34, t_loss*2e34, he3_loss*2e34})

            --network.deuterium = network.deuterium - d_loss*2e34
            --network.tritium = network.tritium - t_loss*2e34
            --network.helium_3 = network.helium_3 - he3_loss*2e34
            --if network.deuterium < 0 then network.deuterium = 0 end
            --if network.tritium < 0 then network.tritium = 0 end
            --if network.helium_3 < 0 then network.helium_3 = 0 end
            
            --rfpower.update_gui_bar(network, "deuterium", plasma_volume, "u", math.floor(network.deuterium*1000)/1000)
            --rfpower.update_gui_bar(network, "tritium", plasma_volume, "u", math.floor(network.tritium*1000)/1000)
            --rfpower.update_gui_bar(network, "helium_3", plasma_volume, "u", math.floor(network.helium_3*1000)/1000)

            --[[fusion_energy = max_particles*((
                    network.deuterium*(
                        rfpower.estimate_r(network, "D-D_T")
                    + rfpower.estimate_r(network, "D-D_He3")
                    )
                    + network.tritium * rfpower.estimate_r(network, "D-T")
                    + network.helium_3 * rfpower.estimate_r(network, "D-He3")
                )*network.deuterium
                + network.tritium*(
                    rfpower.estimate_r(network, "T-T")*network.tritium
                + rfpower.estimate_r(network, "T-He3")*network.helium_3
                )
                + rfpower.estimate_r(network, "He3-He3")*network.helium_3^2
            )/(60*plasma_volume)]] --TODO m^3 to u
        elseif network.tritium > 0 then --TODO
            local e = rfpower.estimate_r(network, "T-T")*network.tritium
            if network.helium_3 > 0 then
                e = network.tritium*(e + rfpower.estimate_r(network, "T-He3")*network.helium_3)
                + rfpower.estimate_r(network, "He3-He3")*network.helium_3^2
            end
            fusion_energy = e*max_particles/(60*plasma_volume)
        elseif network.helium_3 > 0 then --TODO
            local e = rfpower.estimate_r(network, "He3-He3")*network.helium_3
            if network.tritium > 0 then
                e = network.helium_3*(e + rfpower.estimate_r(network, "T-He3"))
                + rfpower.estimate_r(network, "T-T")*network.tritium^2
            end
            fusion_energy = e*max_particles/(60*plasma_volume)
        end

        if fusion_energy ~= fusion_energy or fusion_energy == -1/0 or fusion_energy == 1/0 then --math broke, just kinda happens sometimes
            fusion_energy = 0
        end
-------- #endregion --------

        --[[local fusion_factor = rfpower.estimate_r((network.plasma_temperature*1e6)/k_per_ev, rfp_datasets[recipe], rfp_dataset_sizes[recipe])-- *1.2e2
        if current_tick%math.ceil(30*math.random())==0 then
            fusion_factor = fusion_factor*(math.random()/8+0.9375)
            energy_loss = energy_loss*(math.random()+0.5)
        end
        local fusion_energy = (particle_count_in_plasma*fusion_factor*dt_energy*5e18)/60]]

        -- #region OTHER SIMULATIONS --
        local energy_in = (network.heater_power + max_field_strength/100*network.magnetic_field_strength + divertor_strength/5)*60/1e6

        if network.systems == "right" then
            energy_in = energy_in + systems_consumption*60/1e6
        else energy_loss = energy_loss*1.75 end
        if network.magnetic_field == "right" then
            energy_in = energy_in + min_field_strength*60/1e6
        else
            energy_loss = energy_loss*3

            if network.plasma_temperature > 0.001 then
                network.wall_integrity = network.wall_integrity - network.plasma_temperature/5
                if network.wall_integrity < 0 then network.wall_integrity = 0 end
                for idx, v in pairs(network.guis.bars) do
                    if v["wall-integrity"] and v["wall-integrity"].valid then
                        v["wall-integrity"].value = network.wall_integrity/100
                    end
                end
            end
        end
        
        local current_temp = network.plasma_temperature + (
            network.heater_power
            - 0.05
            --- network.plasma_temperature^energy_loss - network.plasma_temperature*energy_loss*2e4 --not realistic at all, but it seems to work well gameplay-wise
            --+ fusion_energy
        )/(plasma_mass*5920.5) --temp = energy/(mass*specific_heat)
        --if current_temp < 0 or current_temp ~= current_temp then current_temp = 0 end
        --log(serpent.block{current_temp, network.plasma_temperature, plasma_mass})
        -- #endregion --

        -- #region UPDATE GUI --
        network.energy_input = math.floor(energy_in)
        rfpower.update_gui_bar(network, "energy_input", 1000, "MW")
    
        network.energy_output = math.floor(fusion_energy*0.4*60/1e6)
        rfpower.update_gui_bar(network, "energy_output", 1000, "MW")
    
        network.plasma_temperature = current_temp
        rfpower.update_gui_bar(network, "plasma_temperature", 200, " M°C", math.floor(current_temp)) --technically K but °C looks better and is practically the same here
        -- #endregion --

        if current_tick%60==0 then
            game.print(network.wall_integrity)
            log(network.wall_integrity)
            --game.print(network.heater_power*60/1e6 .."MW ("..network.heater_power/rfpower.heater_capacity*100 .."%)")
            --game.print(network.wall_integrity)
            --game.print((network.plasma_temperature*1e6)/k_per_ev)
            --game.print(serpent.line(rfpower.estimate_r((network.plasma_temperature*1e6)/k_per_ev, d_t, d_t_size)))
            --game.print(serpent.line{particle_counts_in_plasma,  current_temp, (current_temp*1e6)/k_per_ev, network.fusion_rate, network.fusion_rate*60/1e6, energy_loss_per_MK*network.plasma_temperature*(math.math.random()+0.5)*60/1e6})
        end
    elseif current_tick%20==0 then --check if everything is at 0, make it so
        if network.plasma_temperature ~= 0 then network.plasma_temperature = 0; rfpower.update_gui_bar(network, "plasma_temperature", 200, " M°C", 0) end
        if network.energy_input ~= 0 then network.energy_input = 0; rfpower.update_gui_bar(network, "energy_input", 1000, "MW") end
        if network.energy_output ~= 0 then network.energy_output = 0; rfpower.update_gui_bar(network, "energy_output", 1000, "MW") end
    end
end
-- #endregion --