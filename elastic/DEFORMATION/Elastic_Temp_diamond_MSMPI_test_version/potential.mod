# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# we must undefine any fix ave/* fix before using reset_timestep
if "$(is_defined(fix,avp))" then "unfix avp"
reset_timestep 0

# ----- Potential settings (ReaxFF)-----
# X. Li, Comput. Mater. Sci., 169 (2019) 109143.; http://dx.doi.org/10.1016/j.commatsci.2019.109143
pair_style	reax/c lmp_control
pair_coeff	* * ffield.reax.C C
fix f1 all qeq/reax 1 0.0 10.0 1e-6 reax/c

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup output

fix avp all ave/time  ${nevery} ${nrepeat} ${nfreq} c_thermo_press mode vector
thermo		${nthermo}
thermo_style custom step temp pe press f_avp[1] f_avp[2] f_avp[3] f_avp[4] f_avp[5] f_avp[6]
thermo_modify norm no

# Setup MD

timestep ${timestep}
fix 4 all nve
if "${thermostat} == 1" then &
   "fix 5 all langevin ${temp} ${temp} ${tdamp} ${seed}"


