echo set xlabel "Distance / nm" > plot.gp
echo set xtics 0.1 >> plot.gp
echo set mxtics 5 >> plot.gp
echo set ylabel "G(r)" >> plot.gp
echo set mytics 5 >> plot.gp
echo plot "out_rdf.txt" u ($2/10):3 w l t "C-C", "out_rdf.txt" u ($2/10):5 w l t "H-H", "out_rdf.txt" u ($2/10):7 w l t "C-H" >> plot.gp
echo pause -1  >> plot.gp
gnuplot plot.gp
del plot.gp