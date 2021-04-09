#!/bin/bash

rm -f -r cluster.vasp

cp *.vasp tmp1.vasp
sed -i 's/\r//g' tmp1.vasp # Windows (CRLF) -> Linux (LF)

rc=`awk '{if(NR==2){print $1}}' settings.txt`
echo "rcut: $rc"

# new center coord.
xnc=`awk '{if(NR==2){print $2}}' settings.txt`
ync=`awk '{if(NR==2){print $3}}' settings.txt`
znc=`awk '{if(NR==2){print $4}}' settings.txt`
echo "new center position; $xnc, $ync, $znc"

xo=`awk '{if(NR==2){print $5}}' settings.txt`
yo=`awk '{if(NR==2){print $6}}' settings.txt`
zo=`awk '{if(NR==2){print $7}}' settings.txt`
echo "x,y,z of origin: $xo, $yo, $zo"

awk -v rc=$rc -v xo=$xo -v yo=$yo -v zo=$zo -v xnc=$xnc -v ync=$ync -v znc=$znc '{if(NR<9){printf "%s \n",$0}else if(NR>=9 && (($1-xo)**2.0+($2-yo)**2.0+($3-zo)**2.0)**(1.0/2.0)<=rc){printf " %9.5f %9.5f %9.5f \n",($1-xo+xnc),($2-yo+ync),($3-zo+znc)}}' tmp1.vasp >  tmp2.vasp

total=`cat tmp2.vasp | wc -l `
echo "total line : $total"

awk -v total=$total -v xnc=$xnc -v ync=$ync -v znc=$znc '{if(NR==3){printf " %-15.8f 0.00000000 0.00000000 \n",xnc*2}else if(NR==4){printf " 0.00000000 %-15.8f 0.00000000 \n",ync*2}else if(NR==5){printf " 0.00000000 0.00000000 %-15.8f \n",znc*2}else if(NR==7){printf " %i \n",(total-8)}else{printf "%s \n",$0}}' tmp2.vasp >  cluster.vasp

rm -f -r tmp1.vasp tmp2.vasp

#sed -i 's/$/\r/g' cluster.vasp # Linux (LF) -> Windows (CRLF)
