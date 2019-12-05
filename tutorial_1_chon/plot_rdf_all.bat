echo set xlabel "Distance / nm" > plot.gp
echo set xtics 0.1 >> plot.gp
echo set mxtics 5 >> plot.gp
echo set ylabel "G(r)" >> plot.gp
echo set mytics 5 >> plot.gp
echo set y2label "CN(r)" >> plot.gp
echo set y2tics  >> plot.gp
echo set my2tics 5 >> plot.gp
echo plot "out_rdf.txt" u ($2/10):23 w l t "Total", "out_rdf.txt" u ($2/10):24 w l t "Cumulative coordination number" axis x1y2 >> plot.gp
echo pause -1  >> plot.gp
gnuplot plot.gp
del plot.gp