# NOTE: This script can be modified for different atomic structures, 
# units, etc. See in.elastic for more info.
#

variable temp equal 300.0                # temperature of initial sample [K]
variable timestep equal 0.01             # timestep

# Define the finite deformation size. Try several values of this
# variable to verify that results do not depend on it.
variable up equal 2.0e-2

# metal units, elastic constants in eV/A^3
#units		metal
#variable cfac equal 6.2414e-7
#variable cunits string eV/A^3

# metal units, elastic constants in GPa
#units		metal
#variable cfac equal 1.0e-4
#variable cunits string GPa

# real units, elastic constants in GPa
units		real
variable cfac equal 1.01325e-4
variable cunits string GPa

# Define MD parameters
variable nevery equal 10                  # sampling interval
variable nrepeat equal 10                 # number of samples
variable nfreq equal ${nevery}*${nrepeat} # length of one average
variable nthermo equal ${nfreq}           # interval for thermo output
variable nequil equal 10*${nthermo}       # length of equilibration run
variable nrun equal 3*${nthermo}          # length of equilibrated run
#variable temp equal 2000.0                # temperature of initial sample
#variable timestep equal 0.001             # timestep
variable mass1 equal 28.06                # mass
variable adiabatic equal 0                # adiabatic (1) or isothermal (2)
variable tdamp equal 0.01                 # time constant for thermostat
variable seed equal 123457                # seed for thermostat

# generate the box and atom positions using a diamond lattice

dimension    3
boundary     p p p
atom_style   charge
read_data    data.in
replicate    1 1 1
change_box   all triclinic

mass 1 12.011 # C

velocity	all create ${temp} 87287


