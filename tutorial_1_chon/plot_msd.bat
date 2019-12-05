echo set xlabel "Time / ps" > plot.gp
echo set xtics 0.1 >> plot.gp
echo set mxtics 5 >> plot.gp
echo set ylabel "r^2 / Angstrom^2" >> plot.gp
echo set mytics 5 >> plot.gp
echo plot "out_all_msd.txt" u ($1*0.5/1000):2 w l t "Total", "out_C_msd.txt" u ($1*0.5/1000):2 w l t "C", "out_H_msd.txt" u ($1*0.5/1000):2 w l t "H", "out_O_msd.txt" u ($1*0.5/1000):2 w l t "O", "out_N_msd.txt" u ($1*0.5/1000):2 w l t "N"  >> plot.gp
echo pause -1  >> plot.gp
gnuplot plot.gp
del plot.gp