-- #region --TODO TESTING CONSTANTS --
rfpower.const = {
    boltzmann_constant = 1.380649e-23, --J/K
    k_per_ev = 11604.52500617,
    joules_per_ev = 1.6021773e-19,
    min_field_strength = 20e6/60, --J/t; same as ITER
    max_field_strength = 50e6/60, --J/t
    systems_consumption = 100e6/60, --J/t; same as ITER?
    max_divertor_strength = 750e6/60, --J/t
    tritium_atomic_mass = 3.016; deuterium_atomic_mass = 2.014, --amu or g/mol
    avogadros_constant = 6.02214076e23,
    c = 299792458, --m/s
    cs = 299792458^2,
    pm_amu = { --amu (g/mol); particle masses
        T = 3.0160492779, D = 2.01410177812, He3 = 3.0160293201, He4 = 4.00260325413,
        n = 1.00866491588, p = 1.007276466583,
    },

    atmosphere_density = 2.504e25, --atoms per m^3 --TODO: find a more precise value

    ml_per_unit = 25000/523,

    min_plasma_density = 10e19*4, --particles/m^3, same as iter

    reactor_volume = 8300, --m^3
    heater_capacity = 400e6, --W
}
local c = rfpower.const

c.amu_per_kg = c.avogadros_constant*1e3
c.pm = { --kg; particle masses
    T = c.pm_amu.T/c.amu_per_kg, D = c.pm_amu.D/c.amu_per_kg, He3 = c.pm_amu.He3/c.amu_per_kg, He4 = c.pm_amu.He4/c.amu_per_kg,
    n = c.pm_amu.n/c.amu_per_kg, p = c.pm_amu.p/c.amu_per_kg,
    --T = p+n+n, D = p+n, He3 = p+p+n, He4 = (p+n)*2
}

c.reaction_energies = { --eV; total energy result from reaction
    ["D-D_He3"] = (c.pm.D*2 - c.pm.He3-c.pm.n)*c.cs/c.joules_per_ev, -- E=mc^2
    ["D-D_T"]   = (c.pm.D*2 - c.pm.T-c.pm.p)*c.cs/c.joules_per_ev,
    ["D-T"]     = (c.pm.D+c.pm.T - c.pm.He4-c.pm.n)*c.cs/c.joules_per_ev,
    ["D-He3"]   = (c.pm.D+c.pm.He3 - c.pm.He4-c.pm.p)*c.cs/c.joules_per_ev,

    ["T-T"]     = (c.pm.T+c.pm.T - c.pm.He4-c.pm.n-c.pm.n)*c.cs/c.joules_per_ev,
    ["He3-He3"] = (c.pm.He3+c.pm.He3 - c.pm.He4-c.pm.p-c.pm.p)*c.cs/c.joules_per_ev,
    ["T-He3"]   = (c.pm.T+c.pm.He3 - c.pm.He4-c.pm.n-c.pm.p)*c.cs/c.joules_per_ev,
}
c.charged_reaction_energies = { --eV; energy from reaction carried by charged particles
    ["D-D_He3"] = c.reaction_energies["D-D_He3"]/4*3,  -- divide by amount of total neutrons/protons, multiply the result by amount of those that are part of a charged atomic core
    ["D-D_T"]   = c.reaction_energies["D-D_T"],        -- made this up on my own but it seems to fit the real-world values pretty much exactly
    ["D-T"]     = c.reaction_energies["D-T"]    /5*4,
    ["D-He3"]   = c.reaction_energies["D-He3"],

    ["T-T"]     = c.reaction_energies["T-T"]    /6*4,
    ["He3-He3"] = c.reaction_energies["He3-He3"],
    ["T-He3"]   = c.reaction_energies["T-He3"]  /6*5,
}

c.atoms_per_unit = c.ml_per_unit*1e-3 * c.atmosphere_density
c.d_kg_per_u     = c.atoms_per_unit*c.pm.D
c.t_kg_per_u     = c.atoms_per_unit*c.pm.T
c.he3_kg_per_u   = c.atoms_per_unit*c.pm.He3
c.he4_kg_per_u   = c.atoms_per_unit*c.pm.He4

c.d_heat_capacity   = 7113*c.d_kg_per_u
c.t_heat_capacity   = 4728*c.t_kg_per_u
c.he3_heat_capacity = 5188*c.he3_kg_per_u
c.he4_heat_capacity = c.he3_heat_capacity
--[[log("pm_amu: "..serpent.block(pm_amu))
log("c.pm: "..serpent.block(c.pm))
log("r_e: "..serpent.block(reaction_energies))]]

c.reactor_plasma_capacity = c.min_plasma_density/c.atoms_per_unit --units/m^3
c.reactor_plasma_capacity_u = c.reactor_volume*c.reactor_plasma_capacity --units; per reactor
--log(serpent.block{reaction_energies, charged_reaction_energies})
-- #endregion --
