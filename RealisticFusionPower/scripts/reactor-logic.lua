--TODO TESTING CONSTANTS --
local boltzmann_constant = 1.380649e-23 --J/K
local k_per_ev = 11604.52500617
local joules_per_ev = 1.6021773e-19
local min_field_strength = 20e6/60 --J/t; same as ITER
local max_field_strength = 50e6/60 --J/t; ITER doesn't need anything because of superconductors afaik, but it'd probably just confuse people so...
local systems_consumption = 100e6/60 --J/t; same as ITER?
local max_divertor_strength = 750e6/60 --J/t
local max_heating = 1e9/60  --J/t
local plasma_volume = 840    --m^3; also the same as ITER
local tritium_atomic_mass = 3.016; local deuterium_atomic_mass = 2.014 --amu or g/mol
local avogadros_constant = 6.02214086e23
local amu_per_kg = avogadros_constant*1e3
local c = 299792458
local cs = c^2
local pm = { --kg; particle masses
    T = 3.01604928/amu_per_kg, D = 2.013553212745/amu_per_kg, He3 = 3.016029/amu_per_kg,
    He4 = 4.002603254/amu_per_kg, n = 1.67492749804e-27, p = 1.67262192e-27
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
--log(serpent.block(reaction_energies))

local datasets = require(".cross-section-data/DATASETS-reactivities")
local dataset_sizes = {}
local last_indexes = {}
for k, v in pairs(datasets) do
    dataset_sizes[k] = table_size(v)   --built-in Factorio function
    last_indexes[k] = 5
    --log(k)

    for i, _v in ipairs(v) do --premultiply reactivities to reduce runtime cost
        datasets[k][i][2] = _v[2]*reaction_energies[k]
    end
end

local function binsearch(data, size, value)
    --modified binary search
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

local function estimate_sig(temperature, dataset)
    local target_energy = (temperature*1e6)/k_per_ev
    local data = datasets[dataset]
    --local dataset_size = dataset_sizes[dataset]
    local nearest_down,nearest_up = last_indexes[dataset],last_indexes[dataset]+1

    if data[nearest_down][1] > target_energy then
        if nearest_down > 1 then
            if data[nearest_down-1][1] > target_energy then --data way off
                nearest_down,nearest_up = binsearch(data, dataset_sizes[dataset], target_energy)
                last_indexes[dataset] = nearest_down
                if nearest_down == nearest_up then return data[nearest_down][2] end
            else
                nearest_up = nearest_down
                nearest_down = nearest_down-1
                last_indexes[dataset] = nearest_down
            end
        end
    elseif data[nearest_up][1] < target_energy then
        if nearest_down < dataset_sizes[dataset]-1 then
            if data[nearest_up+1][1] < target_energy then --data way off
                nearest_down,nearest_up = binsearch(data, dataset_sizes[dataset], target_energy)
                last_indexes[dataset] = nearest_down
                if nearest_down == nearest_up then return data[nearest_down][2] end
            else
                nearest_down = nearest_up
                nearest_up = nearest_up+1
                last_indexes[dataset] = nearest_down
            end
        end
    else return data[nearest_up][2] end


    --estimate value at energy_ev by (mathematically) plotting a line between the two closest points
    local nearest_down_e = data[nearest_down][1]
    local nearest_down_sig = data[nearest_down][2]
    return ((target_energy - nearest_down_e)/(data[nearest_up][1] - nearest_down_e)) * (data[nearest_up][2] - nearest_down_sig) + nearest_down_sig
end

local function update_gui_bar(reactor, name, max, unit, value)
    if reactor.systems == "right" then
        value = value or reactor[name]
        for idx, v in pairs(reactor.guis.bars) do
            local new_name = name:gsub("_","-")
            if v[new_name] and v[new_name].valid then
                v[new_name].value = value/max
                v[new_name].parent["rf-"..new_name.."-value-frame"]["rf-"..new_name.."-value"].caption = string.sub(value, 1,6)..unit
            end
        end
    end
end

return function(reactor, current_tick)
    local plasma_mass = reactor.total_plasma*plasma_volume*(0.18+0.27)/2
    for _,k in ipairs{"deuterium", "tritium", "helium_3"} do
        local old = reactor[k]
        if reactor.total_plasma <= 0.952 and reactor[k.."_input"] > 0 then
            reactor[k] = (reactor[k] + reactor[k.."_input"]/10)
        end
        if reactor[k] > 0 and reactor[k.."_removal"] > 0 then
            reactor[k] = reactor[k] - reactor[k.."_removal"]/10
        end

        if old ~= reactor[k] then
            if reactor[k] < 0 then reactor[k] = 0
            elseif reactor[k] > 800 then reactor[k] = 800 end
            update_gui_bar(reactor, k, 840, "m³")
            --reactor.plasma_temperature = reactor.plasma_temperature*(plasma_mass * 5920.5) --temp = energy/(mass*specific_heat)
        end
    end
    
    --TODO TESTING VARIABLES --
    reactor.total_plasma = (reactor.deuterium + reactor.tritium + reactor.helium_3)/840
    --log(serpent.line{reactor.deuterium, reactor.tritium, reactor.helium_3})
    update_gui_bar(reactor, "total_plasma", 840, "m³", reactor.total_plasma*840)
    local current_heating = max_heating/100*reactor.plasma_heating
    local divertor_strength = max_divertor_strength*reactor.divertor_strength/100
    local max_particles = (1e20*plasma_volume)^2
    local energy_loss = 120/60  --J/t/K; completely arbitrary value, as setting it to something truly realistic would probably just make the reactor not produce any net energy

    local fusion_energy = 0

    --log(reactor.total_plasma)
    if reactor.total_plasma > 0 then
        if reactor.deuterium > 0 then
            local d_level = reactor.deuterium/plasma_volume
            local t_level = reactor.tritium/plasma_volume
            local he3_level = reactor.helium_3/plasma_volume
            --log(serpent.line{d_level, t_level, he3_level})

            local dd_t_chance = estimate_sig(reactor.plasma_temperature, "D-D_T")*(d_level^2)
            local dd_he3_chance = estimate_sig(reactor.plasma_temperature, "D-D_He3")*(d_level^2)
            local dt_chance = estimate_sig(reactor.plasma_temperature, "D-T")*d_level*t_level
            local dhe3_chance = estimate_sig(reactor.plasma_temperature, "D-He3")*d_level*he3_level
            local tt_chance = estimate_sig(reactor.plasma_temperature, "T-T")*(t_level^2)
            local the3_chance = estimate_sig(reactor.plasma_temperature, "T-He3")*t_level*he3_level
            local he3he3_chance = estimate_sig(reactor.plasma_temperature, "He3-He3")*(he3_level^2)

            --log(serpent.block{dd_t_chance, dd_he3_chance, dt_chance, dhe3_chance, tt_chance, the3_chance, he3he3_chance})

            fusion_energy = max_particles*joules_per_ev*6e15*(
                dd_t_chance + dd_t_chance
                + dd_he3_chance
                + dt_chance
                + dhe3_chance
                + tt_chance
                + the3_chance
                + he3he3_chance
            )/60

            local d_loss = (dd_t_chance + dd_he3_chance)*2 + (dt_chance + dhe3_chance)
            local t_loss = tt_chance*2 + (dt_chance + the3_chance) - dd_t_chance
            local he3_loss = he3he3_chance*2 + (dhe3_chance + the3_chance) - dd_he3_chance
            if d_loss ~= d_loss or d_loss == 1/0 or d_loss == -1/0 then d_loss = 0 end
            if t_loss ~= t_loss or t_loss == 1/0 or d_loss == -1/0 then t_loss = 0 end
            if he3_loss ~= he3_loss or he3_loss == 1/0 or d_loss == -1/0 then he3_loss = 0 end

            --log(serpent.line{d_loss*2e34, t_loss*2e34, he3_loss*2e34})

            reactor.deuterium = reactor.deuterium - d_loss*2e34
            reactor.tritium = reactor.tritium - t_loss*2e34
            reactor.helium_3 = reactor.helium_3 - he3_loss*2e34
            if reactor.deuterium < 0 then reactor.deuterium = 0 end
            if reactor.tritium < 0 then reactor.tritium = 0 end
            if reactor.helium_3 < 0 then reactor.helium_3 = 0 end
            
            update_gui_bar(reactor, "deuterium", 840, "m³", math.floor(reactor.deuterium*1000)/1000)
            update_gui_bar(reactor, "tritium", 840, "m³", math.floor(reactor.tritium*1000)/1000)
            update_gui_bar(reactor, "helium_3", 840, "m³", math.floor(reactor.helium_3*1000)/1000)

            --[[fusion_energy = max_particles*((
                    reactor.deuterium*(
                        estimate_sig(reactor.plasma_temperature, "D-D_T")
                    + estimate_sig(reactor.plasma_temperature, "D-D_He3")
                    )
                    + reactor.tritium * estimate_sig(reactor.plasma_temperature, "D-T")
                    + reactor.helium_3 * estimate_sig(reactor.plasma_temperature, "D-He3")
                )*reactor.deuterium
                + reactor.tritium*(
                    estimate_sig(reactor.plasma_temperature, "T-T")*reactor.tritium
                + estimate_sig(reactor.plasma_temperature, "T-He3")*reactor.helium_3
                )
                + estimate_sig(reactor.plasma_temperature, "He3-He3")*reactor.helium_3^2
            )/(60*plasma_volume)]] --TODO m^3 to u
        elseif reactor.tritium > 0 then
            local e = estimate_sig(reactor.plasma_temperature, "T-T")*reactor.tritium
            if reactor.helium_3 > 0 then
                e = reactor.tritium*(e + estimate_sig(reactor.plasma_temperature, "T-He3")*reactor.helium_3)
                + estimate_sig(reactor.plasma_temperature, "He3-He3")*reactor.helium_3^2
            end
            fusion_energy = e*max_particles/(60*plasma_volume)
        elseif reactor.helium_3 > 0 then
            local e = estimate_sig(reactor.plasma_temperature, "He3-He3")*reactor.helium_3
            if reactor.tritium > 0 then
                e = reactor.helium_3*(e + estimate_sig(reactor.plasma_temperature, "T-He3"))
                + estimate_sig(reactor.plasma_temperature, "T-T")*reactor.tritium^2
            end
            fusion_energy = e*max_particles/(60*plasma_volume)
        end

        if fusion_energy ~= fusion_energy or fusion_energy == -1/0 or fusion_energy == 1/0 then --math broke
            fusion_energy = 0
        end





        --[[local fusion_factor = estimate_sig((reactor.plasma_temperature*1e6)/k_per_ev, datasets[recipe], dataset_sizes[recipe])-- *1.2e2
        if current_tick%math.ceil(30*math.random())==0 then
            fusion_factor = fusion_factor*(math.random()/8+0.9375)
            energy_loss = energy_loss*(math.random()+0.5)
        end
        local fusion_energy = (particle_count_in_plasma*fusion_factor*dt_energy*5e18)/60]]
    
    
        local energy_in = (current_heating + max_field_strength/100*reactor.magnetic_field_strength + divertor_strength/5)*60/1e6
    
        if reactor.systems == "right" then
            energy_in = energy_in + systems_consumption*60/1e6
        else energy_loss = energy_loss*1.75 end
        if reactor.magnetic_field == "right" then
            energy_in = energy_in + min_field_strength*60/1e6
        else
            energy_loss = energy_loss*3
    
            if reactor.plasma_temperature > 0.001 then --100kK
                reactor.wall_integrity = reactor.wall_integrity - reactor.plasma_temperature/5
                if reactor.wall_integrity < 0 then reactor.wall_integrity = 0 end
                for idx, v in pairs(reactor.guis.bars) do
                    if v["wall-integrity"] and v["wall-integrity"].valid then
                        v["wall-integrity"].value = reactor.wall_integrity/100
                    end
                end
            end
        end
    
        reactor.energy_input = math.floor(energy_in)
        update_gui_bar(reactor, "energy_input", 1000, "MW")
    
        reactor.energy_output = math.floor(fusion_energy*0.4*60/1e6)
        update_gui_bar(reactor, "energy_output", 1000, "MW")
    
        local current_temp = reactor.plasma_temperature + (
            current_heating
            - reactor.plasma_temperature^energy_loss - reactor.plasma_temperature*energy_loss*2e4
            + fusion_energy*0.25
            --- divertor_strength
        )/(plasma_mass*5920.5) --temp = energy/(mass*specific_heat)
        if current_temp < 0 or current_temp ~= current_temp then current_temp = 0 end
        --log(serpent.block{current_temp, reactor.plasma_temperature, plasma_mass})
        reactor.plasma_temperature = current_temp
        update_gui_bar(reactor, "plasma_temperature", 200, " M°C", math.floor(current_temp)) --technically K but °C looks better and is practically the same here
    
        --if fusion_energy ~= 0 then log(fusion_energy*60/1e6) end
        --if current_tick%60==0 then
            --game.print(reactor.wall_integrity)
            --game.print((reactor.plasma_temperature*1e6)/k_per_ev)
            --game.print(serpent.line(estimate_sig((reactor.plasma_temperature*1e6)/k_per_ev, d_t, d_t_size)))
            --game.print(serpent.line{particle_counts_in_plasma,  current_temp, (current_temp*1e6)/k_per_ev, reactor.fusion_rate, reactor.fusion_rate*60/1e6, energy_loss_per_MK*reactor.plasma_temperature*(math.math.random()+0.5)*60/1e6})
        --end
    elseif current_tick%20==0 then
        if reactor.plasma_temperature ~= 0 then reactor.plasma_temperature = 0; update_gui_bar(reactor, "plasma_temperature", 200, " M°C", 0) end
        if reactor.energy_input ~= 0 then reactor.energy_input = 0; update_gui_bar(reactor, "energy_input", 1000, "MW") end
        if reactor.energy_output ~= 0 then reactor.energy_output = 0; update_gui_bar(reactor, "energy_output", 1000, "MW") end
    end
end