
#! note: I have no idea how any of this works, a friend of mine wrote this because I can't be bothered to learn python
#  gets averaged reactivities from cross-sections
#  modified from https://scipython.com/blog/nuclear-fusion-cross-sections/

import numpy as np
from scipy.constants import e
import json
from pathlib import Path

# Reactant masses in atomic mass units (u).
u = 1.66053906660e-27

masses = {'D': 2.014, 'T': 3.016, 'He3': 3.016, "Li6": 6.015122}

sig_names = {
    #'D-T': 'D-T.json',
    #"D-D": "D-D.json",
    #"D-He3": "D-He3.json",
    #"He3-He3": "He3-He3.json",
    #"T-He3": "T-He3.json",
    #"T-T": "T-T.json",
    "D-Li6": "D-Li6.json"
}
    
sig_labels = {'D-T': '$\mathrm{D-T}$',
            'D-D': '$\mathrm{D-D}$',
            'D-He3': '$\mathrm{D-^He3}$',
            'He3-He3': '$\mathrm{^He3-^He3}$',
            'T-He3': '$\mathrm{T-^He3}$',
            'T-T': '$\mathrm{T-T}$',
            'D-Li6': '$\mathrm{D-^Li6}$',
            }

sig, E = {}, {}


class read:
    def __init__(self, m1, m2, sig):
        self.m1, self.m2, self.sig = m1, m2, sig
        self.mr = self.m1 * self.m2 / (self.m1 + self.m2)

    @classmethod
    def read_data(cls, sig_name):

        json_data = json.loads(open(sig_name, "r").read())
        
        E_array   = np.array([_dict["E"]/1.e6 for _dict in json_data["datasets"][0]["pts"]])
        sig_array = np.array([_dict["Sig"]    for _dict in json_data["datasets"][0]["pts"]])

        E[sig_name[:sig_name.index(".")]] = E_array.tolist()
        Egrid = np.logspace(0, 5, len(E_array))
        
        collider, target = sig_name[:sig_name.index(".")].split('-')
        
        m1, m2 = masses[target], masses[collider]
        E_array *= m1 / (m1 + m2)

        sig = np.interp(Egrid, E_array*1.e3, sig_array*1.e-28)
        
        return cls(m1, m2, sig)

    def __add__(self, other):
        return read(self.m1, self.m2, self.sig + other.sig)

    def __mul__(self, n):
        return read(self.m1, self.m2, n * self.sig)
    __rmul__ = __mul__

    def __getitem__(self, i):
        return self.sig[i]

    def __len__(self):
        return len(self.sig)


def get_reactivity(sig, T):
    """Return reactivity, <sigma.v> in m3.s-1 for temperature T in keV."""

    T = T[:, None]

    fac = 4 * np.pi / np.sqrt(2 * np.pi * sig.mr * u)
    fac /= (1000 * T * e)**1.5
    fac *= (1000 * e)**2 
    func = fac * sig.sig * Egrid * np.exp(-Egrid / T)
    I = np.trapz(func, Egrid, axis=1)
    # Convert from m3.s-1 to cm3.s-1
    return I# * 1.e6


for sig_id, sig_name in sig_names.items():
    sig[sig_id] = read.read_data(sig_name)
    
    Egrid = np.logspace(0, 5, len(sig[sig_id]))
    T = np.logspace(0, 3, len(sig[sig_id]))
            
    Path(f"{sig_id}_reactivity.json").write_text(
        json.dumps({'datasets': [{'pts': [{'E': E*1.e6, 'Sig': rslt_ele} 
        for rslt_ele, E in zip(list(get_reactivity(sig[sig_id], T)), E[sig_id])]}]}),
        encoding='utf-8')