echo "single core calculation"

python3 elastic.py

pause 

rem "parallel version"
rem "set ncore=4"
rem "set OMP_NUM_THREADS=1"
rem "mpirun -np %ncore% python3 elastic.py"