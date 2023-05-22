set ncore=4
set OMP_NUM_THREADS=1

REM mkdir cfg

"C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in in.elastic

pause