set ncore=4

"C:\Program Files\MPICH2\bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -partition %ncore%x1 -in in.neb.cefotaxime-water

python neb_final.py -o dump.neb.final -r dump.neb.cefotaxime-water.* -n %ncore%

pause