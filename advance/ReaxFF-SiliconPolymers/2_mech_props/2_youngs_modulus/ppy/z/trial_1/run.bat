nif exist cfg del cfg
mkdir cfg

set day=%date%
set time=%time%
echo "Job started on my PC at %day% %time%" 

set SLURM_JOBID=%cd%
echo "SLURM_JOBID=%SLURM_JOBID%"

"C:\Program Files\LAMMPS 64-bit 18Jun2019\bin\lmp_serial.exe" -in in.reaxc_z

set day=%date%
set time=%time%
echo "Job finished on my PC at %day% %time%"  