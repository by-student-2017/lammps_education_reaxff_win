set ncore=3

mkdir cfg

set OMP_NUM_THREADS=%ncore%

for %%1 in (in.*) do (
  "C:\Program Files\LAMMPS 64-bit 18Jun2019-MPI\bin\lmp_mpi.exe" -pk omp %ncore% -sf omp -in %%1
  echo input file: %%1
)

set OMP_NUM_THREADS=1

pause