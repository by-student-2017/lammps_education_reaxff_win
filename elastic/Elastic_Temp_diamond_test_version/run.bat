REM mkdir cfg

"C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.elastic

@echo off
for /F "tokens=* USEBACKQ" %%F in (`python --version`) do (set var=%%F)
if "%var:~0,8%"  == "Python 3" (
  python compliance_python3.py > results.txt
) else (
  python3 compliance_python3.py > results.txt
)
type results.txt

pause