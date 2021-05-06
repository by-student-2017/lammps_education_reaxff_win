REM mkdir cfg

"C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.elastic

python3 compliance_python3.py

pause