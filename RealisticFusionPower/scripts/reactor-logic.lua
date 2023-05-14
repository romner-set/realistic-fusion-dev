local function print_log(str) game.print(str); log(str) end
local c = rfpower.const

-- #region DATASETS --
rfp_datasets = require(".cross-section-data/DATASETS-reactivities") --global constants
rfp_dataset_sizes = {}
for k, v in pairs(rfp_datasets) do
    rfp_dataset_sizes[k] = table_size(v) --https://lua-api.factorio.com/latest/Libraries.html
    --log(k)

    --for i, _v in ipairs(v) do --TODO premultiply reactivities to reduce runtime cost
        --rfp_datasets[k][i][2] = _v[2]*reaction_energies[k]
    --end
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
    local target_energy = (network.plasma_temperature*1e6)/c.k_per_ev
    --log(serpent.line{network.plasma_temperature, target_energy})
    if target_energy<=0 then return 0 end
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
    --log("r2: "..serpent.block{target_energy, nearest_down_e, nearest_up, nearest_down_sig, data[nearest_up][1], data[nearest_up][2]})
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
    --[[if false then --TODO current_tick%20==0 then
        local dd_count = 0
        for _,e in pairs(network.heaters) do
            dd_count = dd_count + e.get_fluid_count("rf-deuterium")
        end
        print_log("dd: "..dd_count)
    end]]

    -- #region UPDATE PLASMA --
    network.plasma_volume = network.reactor_volume / (1+network.magnetic_field_strength/9)
    rfpower.update_gui_bar(network, "plasma_volume", network.reactor_volume*10, "m³")
    local plasma_capacity = c.reactor_plasma_capacity_u*(network.reactor_volume/c.reactor_volume)
    local plasma_mass = network.deuterium*c.d_kg_per_u + network.tritium*c.t_kg_per_u + network.helium_3*c.he3_kg_per_u + network.helium_4*c.he4_kg_per_u

    local heat_cap = (
        c.d_heat_capacity   * network.deuterium
      + c.t_heat_capacity   * network.tritium
      + c.he3_heat_capacity * network.helium_3
      + c.he4_heat_capacity * network.helium_4
    )*1e6

    for _,k in ipairs{"deuterium", "tritium", "helium_3", "helium_4"} do
        local old = network[k]
        if network.total_plasma <= 0.95 and network[k.."_input"] > 0 then
            local e = network.plasma_temperature*heat_cap
            network[k] = network[k] + network[k.."_input"]/100000
            heat_cap = (
                c.d_heat_capacity   * network.deuterium
              + c.t_heat_capacity   * network.tritium
              + c.he3_heat_capacity * network.helium_3
              + c.he4_heat_capacity * network.helium_4
            )*1e6
            network.plasma_temperature = e/heat_cap
        end
        if network[k] > 0 and network[k.."_removal"] > 0 then
            local e = network.plasma_temperature*heat_cap
            network[k] = network[k] - network[k.."_removal"]/100000
            heat_cap = (
                c.d_heat_capacity   * network.deuterium
              + c.t_heat_capacity   * network.tritium
              + c.he3_heat_capacity * network.helium_3
              + c.he4_heat_capacity * network.helium_4
            )*1e6
            network.plasma_temperature = e/heat_cap
        end

        if old ~= network[k] then
            if network[k] < 0 then network[k] = 0
            elseif network[k] > plasma_capacity*0.95 then network[k] = plasma_capacity*0.95 end
            --TODO rfpower.update_gui_bar(network, k, plasma_volume, "u")
            --network.plasma_temperature = network.plasma_temperature*(plasma_mass * 5920.5) --temp = energy/(mass*specific_heat)
        end
    end
    --log(network.total_plasma)
    -- #endregion --

    -- #region --TODO TESTING VARIABLES --
    network.total_plasma = (network.deuterium + network.tritium + network.helium_3 + network.helium_4)/plasma_capacity
    --log(serpent.line{network.deuterium, network.tritium, network.helium_3})
    rfpower.update_gui_bar(network, "total_plasma", plasma_capacity, "u", network.total_plasma*plasma_capacity)
    local divertor_strength = c.max_divertor_strength*network.divertor_strength/100
    --local max_particles = (1e20*plasma_capacity)^2
    -- #endregion --

    if network.total_plasma > 0 and plasma_mass > 0 then
-------- #region SIMULATE REACTIONS --------
        local fusion_energy = 0
        local output_fusion_energy = 0

        if network.total_plasma > network.helium_4 then
            local d_number_density   = network.deuterium * c.atoms_per_unit / network.plasma_volume
            local t_number_density   = network.tritium   * c.atoms_per_unit / network.plasma_volume
            local he3_number_density = network.helium_3  * c.atoms_per_unit / network.plasma_volume
            --log("N: "..serpent.line{d_number_density, t_number_density, he3_number_density})

            local dd_t_reactions   = rfpower.estimate_r(network, "D-D_T")   * d_number_density   * d_number_density * 10 --random bullshit GO!
            local dd_he3_reactions = rfpower.estimate_r(network, "D-D_He3") * d_number_density   * d_number_density * 10 --look, I know that I'm supposed to make this realistic and all, but nothing except D-T works properly without these *10s
            local dt_reactions     = rfpower.estimate_r(network, "D-T")     * d_number_density   * t_number_density      --I'll hopefully somehow change the formulas to be more realistic at some point, but this is good enough for now
            local dhe3_reactions   = rfpower.estimate_r(network, "D-He3")   * d_number_density   * he3_number_density * 10
            local tt_reactions     = rfpower.estimate_r(network, "T-T")     * t_number_density   * t_number_density * 20
            local the3_reactions   = rfpower.estimate_r(network, "T-He3")   * t_number_density   * he3_number_density * 100
            local he3he3_reactions = rfpower.estimate_r(network, "He3-He3") * he3_number_density * he3_number_density * 100

            fusion_energy = c.joules_per_ev*(
                  dd_t_reactions   * c.charged_reaction_energies["D-D_T"]
                + dd_he3_reactions * c.charged_reaction_energies["D-D_He3"]
                + dt_reactions     * c.charged_reaction_energies["D-T"]
                + dhe3_reactions   * c.charged_reaction_energies["D-He3"]
                + tt_reactions     * c.charged_reaction_energies["T-T"]
                + the3_reactions   * c.charged_reaction_energies["T-He3"]
                + he3he3_reactions * c.charged_reaction_energies["He3-He3"]
            )/60

            output_fusion_energy = c.joules_per_ev*(
                  dd_t_reactions   * c.reaction_energies["D-D_T"]
                + dd_he3_reactions * c.reaction_energies["D-D_He3"]
                + dt_reactions     * c.reaction_energies["D-T"]
                + dhe3_reactions   * c.reaction_energies["D-He3"]
                + tt_reactions     * c.reaction_energies["T-T"]
                + the3_reactions   * c.reaction_energies["T-He3"]
                + he3he3_reactions * c.reaction_energies["He3-He3"]
            )/60

            --log("C: "..serpent.block{fusion_energy, dd_t_reactions, dd_he3_reactions, dt_reactions, dhe3_reactions, tt_reactions, the3_reactions, he3he3_reactions})

            network.deuterium_usage = (-((dd_t_reactions + dd_he3_reactions)*2 + (dt_reactions + dhe3_reactions))) / c.atoms_per_unit
            network.tritium_usage = (-(tt_reactions*2 + (dt_reactions + the3_reactions) - dd_t_reactions)) / c.atoms_per_unit
            network.helium_3_usage = (-(he3he3_reactions*2 + (dhe3_reactions + the3_reactions) - dd_he3_reactions)) / c.atoms_per_unit
            network.helium_4_usage = (tt_reactions + the3_reactions + he3he3_reactions + dt_reactions + dhe3_reactions) / c.atoms_per_unit

            rfpower.update_gui_bar(network, "deuterium_usage", 1, "u", math.floor(network.deuterium_usage*1000000)/1000*60)
            rfpower.update_gui_bar(network, "tritium_usage", 1, "u", math.floor(network.tritium_usage*1000)/1000*60)
            rfpower.update_gui_bar(network, "helium_3_usage", 1, "u", math.floor(network.helium_3_usage*1000)/1000*60)
            rfpower.update_gui_bar(network, "helium_4_usage", 1, "u", math.floor(network.helium_4_usage*1000)/1000*60)


            network.deuterium = network.deuterium + (network.deuterium_usage / c.atoms_per_unit)
            network.tritium   = network.tritium   + (network.tritium_usage   / c.atoms_per_unit)
            network.helium_3  = network.helium_3  + (network.helium_3_usage  / c.atoms_per_unit)
            network.helium_4  = network.helium_4  + (network.helium_4_usage  / c.atoms_per_unit)
            --if network.deuterium < 0 then network.deuterium = 0 end
            --if network.tritium < 0 then network.tritium = 0 end
            --if network.helium_3 < 0 then network.helium_3 = 0 end
            
            rfpower.update_gui_bar(network, "deuterium", plasma_capacity, "u", math.floor(network.deuterium*1000)/1000)
            rfpower.update_gui_bar(network, "tritium", plasma_capacity, "u", math.floor(network.tritium*1000)/1000)
            rfpower.update_gui_bar(network, "helium_3", plasma_capacity, "u", math.floor(network.helium_3*1000)/1000)
            rfpower.update_gui_bar(network, "helium_4", plasma_capacity, "u", math.floor(network.helium_4*1000)/1000)

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
            )/(60*network.plasma_volume)]] --TODO m^3 to u
        --[[elseif network.tritium > 0 then --TODO
            local e = rfpower.estimate_r(network, "T-T")*network.tritium
            if network.helium_3 > 0 then
                e = network.tritium*(e + rfpower.estimate_r(network, "T-He3")*network.helium_3)
                + rfpower.estimate_r(network, "He3-He3")*network.helium_3^2
            end
            fusion_energy = e*max_particles/(60*network.plasma_volume)
        elseif network.helium_3 > 0 then --TODO
            local e = rfpower.estimate_r(network, "He3-He3")*network.helium_3
            if network.tritium > 0 then
                e = network.helium_3*(e + rfpower.estimate_r(network, "T-He3"))
                + rfpower.estimate_r(network, "T-T")*network.tritium^2
            end
            fusion_energy = e*max_particles/(60*network.plasma_volume)]]
        end

        --if fusion_energy ~= fusion_energy or fusion_energy == -1/0 or fusion_energy == 1/0 then --math broke, just kinda happens sometimes
        --    fusion_energy = 0
        --end
-------- #endregion --------

        --[[local fusion_factor = rfpower.estimate_r((network.plasma_temperature*1e6)/k_per_ev, rfp_datasets[recipe], rfp_dataset_sizes[recipe])-- *1.2e2
        if current_tick%math.ceil(30*math.random())==0 then
            fusion_factor = fusion_factor*(math.random()/8+0.9375)
            energy_loss = energy_loss*(math.random()+0.5)
        end
        local fusion_energy = (particle_count_in_plasma*fusion_factor*dt_energy*5e18)/60]]

        -- #region OTHER SIMULATIONS --
        local energy_in = (network.heater_power/60 + c.max_field_strength/100*network.magnetic_field_strength + divertor_strength/5)*60/1e6

        if network.systems == "right" then
            energy_in = energy_in + c.systems_consumption*60/1e6
        end

        if network.magnetic_field == "right" then
            energy_in = energy_in + c.min_field_strength*60/1e6
        else
            --energy_loss = energy_loss*3

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

        heat_cap = (
              c.d_heat_capacity   * network.deuterium
            + c.t_heat_capacity   * network.tritium
            + c.he3_heat_capacity * network.helium_3
            + c.he4_heat_capacity * network.helium_4
        )*1e6
        --print_log("heat_cap: "..heat_cap)

        local current_temp = network.plasma_temperature

        --for _=1,10 do
            current_temp = current_temp + (
                network.heater_power*10 -- *10 because otherwise it doesn't work... and we don't reaaaaaally need to be 100% realistic if it doesn't even work irl yet, right?
              + fusion_energy * network.plasma_volume
              - 1.04e-19 * (c.atoms_per_unit*network.total_plasma*plasma_capacity / network.plasma_volume)^2 * math.sqrt(current_temp*1e6) * network.plasma_volume * c.joules_per_ev --bremsstrahlung radiation, according to IAEA's fusion book pg.17 (40 in the PDF)
            )/(heat_cap*60) --temp = energy/heat_capacity
            --log(network.heater_power.." "..fusion_energy * network.plasma_volume..(1.04e-19 * (c.atoms_per_unit*network.total_plasma*plasma_capacity / network.plasma_volume)^2 * math.sqrt(current_temp*1e6) * network.plasma_volume * c.joules_per_ev))
            if current_temp < 0 then current_temp = 0 end
            if (current_temp ~= current_temp) or current_temp > 1000 then current_temp = 1000 end
        --end

        --[[local current_temp = network.plasma_temperature + (
            network.heater_power*1e6
          + fusion_energy * network.plasma_volume
          - 1.04e-19 * (c.atoms_per_unit*network.total_plasma*plasma_capacity / network.plasma_volume)^2 * math.sqrt(network.plasma_temperature*1e6/c.k_per_ev) * network.plasma_volume
        )/(heat_cap*60)]] --temp = energy/heat_capacity
        --log(current_temp)
        --current_temp = current_temp - (1.4e-28 * (atoms_per_unit*network.total_plasma*network.plasma_volume)^2 * math.sqrt(current_temp*1e6))/heat_cap/60
        --log("cts: "..serpent.block{temp_after = current_temp, temp_before = network.plasma_temperature, heater_power = network.heater_power, fusion_energy = fusion_energy, plasma_mass = plasma_mass})
        -- #endregion --

        -- #region UPDATE GUI --
        network.energy_input = math.floor(energy_in)
        rfpower.update_gui_bar(network, "energy_input", 1000, "MW")

        network.energy_output = math.floor(output_fusion_energy*network.plasma_volume/1e6)
        rfpower.update_gui_bar(network, "energy_output", 1000, "MW")

        network.plasma_temperature = current_temp
        rfpower.update_gui_bar(network, "plasma_temperature", 1000, " M°C", math.floor(current_temp)) --technically K but °C looks better and is practically the same here
        -- #endregion --

        if current_tick%60==0 then
            --game.print(network.wall_integrity)
            --log(network.wall_integrity)
            --game.print(network.heater_power*60/1e6 .."MW ("..network.heater_power/rfpower.const.heater_capacity*100 .."%)")
            --game.print(network.wall_integrity)
            --game.print((network.plasma_temperature*1e6)/k_per_ev)
            --game.print(serpent.line(rfpower.estimate_r((network.plasma_temperature*1e6)/k_per_ev, d_t, d_t_size)))
            --game.print(serpent.line{particle_counts_in_plasma,  current_temp, (current_temp*1e6)/k_per_ev, network.fusion_rate, network.fusion_rate*60/1e6, energy_loss_per_MK*network.plasma_temperature*(math.math.random()+0.5)*60/1e6})
        end
    --elseif current_tick%20==0 then --check if everything is at 0, make it so
        --if network.plasma_temperature ~= 0 then network.plasma_temperature = 0; rfpower.update_gui_bar(network, "plasma_temperature", 200, " M°C", 0) end
        --if network.energy_input ~= 0 then network.energy_input = 0; rfpower.update_gui_bar(network, "energy_input", 1000, "MW") end
        --if network.energy_output ~= 0 then network.energy_output = 0; rfpower.update_gui_bar(network, "energy_output", 1000, "MW") end
    end
end
-- #endregion --
