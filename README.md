# lammps_education_reaxff_win

------------------------------------------------------------------------------
## lammps (windows 11 (64 bit))

## Installation (Lammps)
1. LAMMPS Windows Installer Repository (http://packages.lammps.org/windows.html) -> LAMMPS Binaries Repository: ./legacy/admin/64bit (https://rpm.lammps.org/windows/legacy/admin/64bit/index.html)
2. LAMMPS-64bit-22Dec2022-MSMPI-admin.exe (https://rpm.lammps.org/windows/legacy/admin/64bit/LAMMPS-64bit-22Dec2022-MSMPI-admin.exe)
- LAMMPS Windows Installer Repository -> legacy -> admin -> 64bit -> LAMMPS-64bit-22Dec2022-MSMPI-admin.exe

## Microsoft MPI
1. Microsoft MPI v10.1.2 (https://www.microsoft.com/en-us/download/details.aspx?id=100593)

## Gnuplot, Ovito and Python3
* Gnuplot (http://www.gnuplot.info/)
  http://www.yamamo10.jp/yamamoto/comp/gnuplot/inst_win/index.php
* Ovito (https://www.ovito.org/windows-downloads/)

## Python3 (installation) on PowerShell
1. python3
2. python3 -m pip install numpy

## Usage (MS-MPI version)
1. click run_msmpi.bat
2. cfg folder > click *.cfg
------------------------------------------------------------------------------
# plot the temperature of each atom

- MSMPI_heat_map version file
1. *.cfg -> Ovito -> (upper right) Add modification... 
2. Color coding -> Input property: f_ave_tempatom
3. (click) Adjust range

------------------------------------------------------------------------------
## lammps (windows 10 (64 bit))


## Installation
1. LAMMPS Windows Installer Repository (http://packages.lammps.org/windows.html) > "their own download area" > ”64bit"
  (https://rpm.lammps.org/windows/admin/64bit/index.html)
2. LAMMPS-64bit-18Jun2019.exe (https://rpm.lammps.org/windows/admin/64bit/LAMMPS-64bit-18Jun2019.exe)


## gnuplot and Ovito
* gnuplot（http://www.gnuplot.info/）
  http://www.yamamo10.jp/yamamoto/comp/gnuplot/inst_win/index.php
* Ovito（https://www.ovito.org/windows-downloads/）


## Usage (basic, advance, surface, cluster, gcmc and tutorial)
1. click run.bat
2. cfg folder > click *.cfg


## Multi-core calculation
1. see parallel directory


## ffield.reax file
1. see potentials directory

------------------------------------------------------------------------------
## References
* [IR1] [lammps-users] Script for calculating IR spectra
  https://lammps.sandia.gov/threads/msg64502.html
  calc-ir-spectra-from-lammps
  https://github.com/EfremBraun/calc-ir-spectra-from-lammps
* [P1] http://kiff.vfab.org/
  http://kiff.vfab.org/reax
  potentials folder are getting from above URL.
------------------------------------------------------------------------------


------------------------------------------------------------------------------
## MOES (Multi-Objective Evolution Strategy)
- MOES (reaxff): https://apps.dtic.mil/sti/tr/pdf/ADA612711.pdf
- MOES (github): https://github.com/MaOEA/MMO-MOES
- https://www.researchgate.net/profile/Mark-Tschopp/publication/271847845_Understanding_and_Automating_the_Design_Aspects_of_Interatomic_Potential_Design/links/54d4b4750cf2464758063066/Understanding-and-Automating-the-Design-Aspects-of-Interatomic-Potential-Design.pdf
------------------------------------------------------------------------------


## Acknowledgment ######################################
- This project (modified version) is/was partially supported by the following :
  + meguREnergy Co., Ltd.
  + ATSUMITEC Co., Ltd.
