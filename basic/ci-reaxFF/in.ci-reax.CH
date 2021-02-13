#ci-reax potential for CH systems with tabulated ZBL correction
atom_style		charge
units			real

read_data		CH4.dat

pair_style		hybrid/overlay reax/c control checkqeq no table linear 11000
pair_coeff		* * reax/c ffield.ci-reax.CH C H
pair_coeff		1 1 table ci-reaxFF_ZBL.dat CC_cireaxFF 
pair_coeff		1 2 table ci-reaxFF_ZBL.dat CH_cireaxFF 
pair_coeff		2 2 table ci-reaxFF_ZBL.dat HH_cireaxFF

timestep		0.25
fix				1 all nve
fix				2 all temp/berendsen 500.0 3000.0 100.0

fix				3 all reax/c/bonds 100 bonds.reaxc
fix				4 all reax/c/species 10 1 10 species.reaxc

#dump           1 all atom 30 dump.ci-reax.lammpstrj
dump			d1 all cfg 10 cfg/run.*.cfg mass type xs ys zs id type
dump_modify		d1 element C H

variable		energy equal etotal
variable		temperature equal temp
fix				fout1 all ave/time 1 10 10 v_energy v_temperature file out_energy.txt

thermo_style	custom step etotal temp lx vol press
thermo			10

run				3000
