set ncore=3

mkdir cfg

"C:\Program Files\MPICH2\bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition %ncore%x1 -in in.tad

pause