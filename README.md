<h1 align="center">Realistic Fusion 2.0</h1>

<h4 align="center">Repository for the WIP Realistic Fusion mod series for Factorio.
<p align="center">
<a href="#finished-features">Finished features</a> ◈
<a href="#plannedwip-features">Planned/WIP features</a> ◈
<a href="#installation">Installation</a> ◈
<a href="#links-to-the-mod-portal">Links</a>
</p>

## Finished features
### General
- [RFP](https://mods.factorio.com/mod/RealisticFusionPower) & [RFW](https://mods.factorio.com/mod/RealisticFusionWeaponry) 1.x were split into four mods - Realistic Fusion Core, Power, Weaponry and Antimatter (RFC, RFP, RFW & RFA)
- Completely remade most of the gas/plasma/etc icons
### Realistic Fusion - Core
- Added brine, a new oil-like resource
- Added lithium (with graphics borrowed from [Krastorio2](https://mods.factorio.com/mod/Krastorio2)) & a way to extract it from brine
- Improved deuterium extraction, especially GS processing
### Realistic Fusion - Power
- Added (an unbalanced, unrealistic, prototype version of) ICF[^1] reactors, with awesome graphics made by [PreLeyZero](https://mods.factorio.com/user/PreLeyZero)
- **Completely rewrote nearly everything about how the reactors work** using actual, real life formulas & stuff
  - By "real life formulas & stuff" I mean that RFP now **literally simulates a fusion reactor in real-time, close how it should behave in real life.** Sort of...
    - The model is extremely simplified because of performance constraints, but it should still be pretty accurate.
    - To get reasonable values balance-wise, I multiplied the input heater power and some of the fusion reactivities[^2] like D-D[^3]'s by 10.
    - It isn't technically 100% the real thing, but it uses the same equations. At least I think so... honestly, I'm just a highschool student, and this is the kind of stuff normally taught at universities, so it is pretty damn hard to get everything right.
  - Gave reactors and heaters completely custom GUIs for advanced control
  - Made MCF[^4] reactors completely modular
    - Reactors and heaters connected by magnetic confinement pipes form **networks**, which act as one big reactor/heater and can be controlled by clicking on any of the reactors.
    - Because it only has to check Realistic Fusion pipes it shouldn't degrade performance, unless you do something like place 10000 of them at once into a single network.

## Planned/WIP features
- Add modes of operation to the reactors:
  - Manual – controlled directly through the reactor's GUI
  - Remote-controlled – same as manual but can be opened with a GUI button from anywhere
  - Programmable – controlled through circuit signals
  - Automatic – endgame tech, mod computes the optimal setting for each situation itself (ingame called "Predictive AI" or something)
- Make ICF reactors realistic
- Half-done: Revamp tritium & helium-3 production 
  - Tritium is produced by:
    - In small amounts, reprocessing standard fission fuel cells
    - Reprocessing lithium-coated fission fuel cells
    - Tritium-suppressed D-D fusion
  - Helium-3 is produced from tritium decay or He3-suppressed D-D fusion
- Balance everything for actual ingame use outside of sandbox
- Completely recreate the tech tree
- Write a manual for controlling the reactor
- Write all sources into a readable format
- Improve the formulas used for reactor simulation
- Revamp RFA & RFW
- Add compatibilities for other major mods
- ? Rewrite the GUI to use a library instead of the spaghetti code mess that I've created

## Installation
Note: Don't use RFW or RFA yet, they're most likely broken.
### One-time
If you don't care about updates and just want to try out the current version, simply download [this zip file](https://github.com/romner-set/realistic-fusion-dev/archive/refs/heads/master.zip) or clone the repo directly with [git](https://git-scm.com):  
```
git clone https://github.com/romner-set/realistic-fusion-dev.git
```
And move the "RealisticFusionPower" and "RealisticFusionCore" folders into Factorio's mods folder[^5].

### With easy updates using [git](https://git-scm.com)
#### Windows
1. Open the command line by pressing Win+R and typing `cmd`.
2. Type `cd "<DIR>"` where `<DIR>` is the folder where you want to keep the repo files (e.g. `cd "C:\Users\<YOUR_USERNAME>\Downloads"`)
3. Paste this into the command line:
```
git clone https://github.com/romner-set/realistic-fusion-dev.git && mklink /J %AppData%\Factorio\mods\RealisticFusionCore %cd%\realistic-fusion-dev\RealisticFusionCore && mklink /J %AppData%\Factorio\mods\RealisticFusionPower %cd%\realistic-fusion-dev\RealisticFusionPower
```
#### Linux/macOS
Open a terminal, `cd` into a directory of choice and paste this into it:
```
git clone https://github.com/romner-set/realistic-fusion-dev.git && ln -rs realistic-fusion-dev/RealisticFusion* ~/.factorio/mods
```
#### To update, `cd` into the folder again and run `git pull`.

## Links to the mod portal
- [TODO] [Realistic Fusion - Core](https://mods.factorio.com/mod/RealisticFusionCore)
- [v1.x] [Realistic Fusion - Power](https://mods.factorio.com/mod/RealisticFusionPower)
- [v1.x] [Realistic Fusion - Weaponry](https://mods.factorio.com/mod/RealisticFusionWeaponry)
- [TODO] [Realistic Fusion - Antimatter](https://mods.factorio.com/mod/RealisticFusionAntimatter)

### Footnotes
[^1]: **I**nertial **C**onfinement **F**usion. Instead of heating up the gases directly like MCF[^4], ICF heats up small pellets of fuel with lasers.  
[^2]: Amount of fusion reactions per volume, per second.  
[^3]: The X-Y notation represents a fusion reaction between two isotopes, in this case D-D represents the fusion reaction of two deuterium (D) atoms.  
[^4]: **M**agnetic **C**onfinement **F**usion, as opposed to ICF. All pre-2.0 reactors were MCF.  
[^5]: Windows: %AppData%\Factorio\mods  
Linux: ~/.factorio/mods  
macOS: ~/Library/Application Support/factorio/mods
