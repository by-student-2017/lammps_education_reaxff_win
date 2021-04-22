Run these examples as:

mpirun -np 3 lmp_g++ -partition 3x1 -in in.neb.sivac

mpirun -np 8 lmp_g++ -partition 4x2 -in in.neb.sivac

Note that more than 4 replicas should be used for a precise estimate 
of the activation energy corresponding to a transition.


log.lammps
******************************************
RD1: start coordination, 0
RDN: final coordination, 1
RDx: intermediate coordination, 0 < x < 1
******************************************
For replica = 4 case,

1st (RD1=0, RD2=0.33333333, RD3=0.66666667, RDN=1) (equation: RDx = x/(4-1))
0    15.976854    4.2468612   0.52063582    15.976854    15.976854    2.4947451            0    1.8414458            0   -2362.3085   0.33333333   -2361.3399   0.66666667   -2360.2175            1   -2359.8137 

last (RD1=0, RD2=0.17394249, RD3=0.88927237, RDN=1) (after neb)
200    128.47093    10.995596    95.134591    97.008454    97.008454   -1.7409951            0    3.0344104            0   -2337.4052   0.17394249   -2319.4173   0.88927237   -2341.4152            1   -2339.1462 
******************************************

PE1: final energy at start position
PEN: final energy at final position
******************************************
For replica = 4 case,

last (PE1=-2337.4052, PE2=-2319.4173, PE3=-2341.4152, PEN=-2339.1462) (after neb)
200    128.47093    10.995596    95.134591    97.008454    97.008454   -1.7409951            0    3.0344104            0   -2337.4052   0.17394249   -2319.4173   0.88927237   -2341.4152            1   -2339.1462 
******************************************