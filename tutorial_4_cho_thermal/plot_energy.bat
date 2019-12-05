echo set xlabel "Step" > plot.gp
echo set mxtics 5 >> plot.gp
echo set ylabel "Energy / eV" >> plot.gp
echo set mytics 5 >> plot.gp
echo set y2label "Temperature / K" >> plot.gp
echo set y2tics  >> plot.gp
echo set my2tics 5 >> plot.gp
echo plot "out_energy.txt" u 1:2 w l t "Energy", "out_energy.txt" u 1:3 w l t "Temperature" axis x1y2 >> plot.gp
echo pause -1  >> plot.gp
gnuplot plot.gp
del plot.gp

