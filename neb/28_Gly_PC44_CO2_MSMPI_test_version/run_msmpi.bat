set ncore=4

"C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -partition %ncore%x1 -in in.neb.Gly_PC44_CO2

python3 neb_final.py -o dump.neb.final -r dump.neb.Gly_PC44_CO2.* -n %ncore%

pause