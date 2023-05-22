set ncore=4

REM mkdir cfg

"C:\Program Files\Microsoft MPI\Bin\mpiexec.exe" -np %ncore% "C:\Program Files\LAMMPS 64-bit 22Dec2022-MSMPI\bin\lmp.exe" -in in.elastic

@echo off
for /F "tokens=* USEBACKQ" %%F in (`python --version`) do (set var=%%F)
if "%var:~0,8%"  == "Python 3" (
  python compliance_python3.py > results.txt
) else (
  python3 compliance_python3.py > results.txt
)
type results.txt

pause