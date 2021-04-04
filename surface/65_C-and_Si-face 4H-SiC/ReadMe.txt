
## ReaxFF Reactive Molecular Dynamics Study of Orientation Dependence of Initial Silicon Carbide Oxidation
## V. Simonka, A. Hoessinger, J. Weinbub, S. Selberherr
## ACS, J. Phys. Chem. C 
## (2017)
#


Supporting files are devided into three directories as follow:
- Initial_Structures: The C- and Si-face 4H-SiC initial structures for MD simulations.
- Main_Lammps_Code: The code to run in Lammps.
- ReaxFF_Outfiles: The output files of ReaxFF bond counts.


# INITIAL STRUCTURES

This directory contains the initial structure files. Each of the crystal orientation structures include three files:
- .info: general information, i.e., number of atoms, simulation box size, etc.
- .xzy: structure to visualize, e.g., in Jmol
- .txt: input file for Lammps


# MAIN LAMMPS CODE

This directory contains two main scripts for MD simulations in Lammps, i.e., a script for the C- and for the Si-face. See comments in these files for details. 
To successfully run the scripts, add the 1. main file and 2. corresponding initial structure file (.txt) together with a 3. ReaxFF potential file to the same directory.
ReaxFF potential file must be named "ffield.reax". It is available as supporting info from D. A. Newsome et al., J. Phys. Chem. C 116 (2012).
To run the simulation under GNU/Linux, execute on command line with: "./lammps -in main_C-face.in". Note, flag "-in" can be replaced by "<".
To run Lammps in parallel with X number of MPI tasks, use command "mpirun -np X" and beforehand set the desired number Y of OpenMP threads: "export OMP_NUM_THREADS=Y".


# REAXFF OUTFILES

This directory includes two example results of the ReaxFF bond counts for C- and Si-face 4H-SiC simulations. 
Timestep was 1 fs, recording was every 5000 timesteps, and final number of timesteps was 100000.
