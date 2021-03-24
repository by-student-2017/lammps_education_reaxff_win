set ncore=3

mkdir cfg

for %%1 in (in.*) do (
  "C:\Program Files\MPICH2\bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -in %%1
  echo input file: %%1
)

pause