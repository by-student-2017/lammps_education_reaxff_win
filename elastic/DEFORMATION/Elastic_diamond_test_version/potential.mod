# NOTE: This script can be modified for different pair styles 
# See in.elastic for more info.

# ----- Potential settings (ReaxFF)-----
# X. Li, Comput. Mater. Sci., 169 (2019) 109143.; http://dx.doi.org/10.1016/j.commatsci.2019.109143
pair_style	reax/c lmp_control
pair_coeff	* * ffield.reax.C C
fix f1 all qeq/reax 1 0.0 10.0 1e-6 reax/c

# Setup neighbor style
neighbor 1.0 nsq
neigh_modify once no every 1 delay 0 check yes

# Setup minimization style
min_style	     cg
min_modify	     dmax ${dmax} line quadratic

# Setup output
thermo		1
thermo_style custom step temp pe press pxx pyy pzz pxy pxz pyz lx ly lz vol
thermo_modify norm no
