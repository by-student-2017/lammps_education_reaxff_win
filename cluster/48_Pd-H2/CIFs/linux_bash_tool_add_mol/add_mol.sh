#!/bin/bash

rm -f -r cluster.vasp cluster_mol.vasp add_mol.vasp

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

echo " "
echo "----- add molecular sequence -----"
rcm=`awk '{if(NR==5){print $1}}' settings.txt`
echo "rcut for molecule: $rcm"

xm=`awk '{if(NR==7){print $1}}' settings.txt`
ym=`awk '{if(NR==7){print $2}}' settings.txt`
zm=`awk '{if(NR==7){print $3}}' settings.txt`
echo "number of mesh, x, y, z: $xm, $ym, $zm"

ml=`awk '{if(NR==9){print $1}}' settings.txt`
echo "number of molecular position line: $ml"

echo -n > mol.xyz
dx=`awk -v xnc=$xnc '{if(NR==7){print 2.0*xnc/$1}}' settings.txt`
dy=`awk -v ync=$ync '{if(NR==7){print 2.0*ync/$2}}' settings.txt`
dz=`awk -v znc=$znc '{if(NR==7){print 2.0*znc/$3}}' settings.txt`
for rx in `seq 1 $xm`; do
  for ry in `seq 1 $ym`; do
    for rz in `seq 1 $zm`; do
      #
      crcm="0"
      crcm=`awk -v dx=$dx -v rx=$rx -v dy=$dy -v ry=$ry -v dz=$dz -v rz=$rz -v rcm=$rcm '{if(NR==2 && ((dx*(rx-1)-$2)**2.0+(dy*(ry-1)-$3)**2.0+(dz*(rz-1)-$4)**2.0)**(1.0/2.0)>rcm){print "1"}}' settings.txt`
      if [ "$crcm" == "1" ]; then
        for i in `seq 1 $ml`; do
	  moel=`awk -v mli=$i '{if(NR==10+mli){print $1}}' settings.txt`
	  mox=`awk -v mli=$i -v dx=$dx -v rx=$rx '{if(NR==10+mli){print $2+dx*(rx-1)}}' settings.txt`
	  moy=`awk -v mli=$i -v dy=$dy -v ry=$ry '{if(NR==10+mli){print $3+dy*(ry-1)}}' settings.txt`
	  moz=`awk -v mli=$i -v dz=$dz -v rz=$rz '{if(NR==10+mli){print $4+dz*(rz-1)}}' settings.txt`
	  #echo "$moel $mox $moy $moz"
          echo "$moel $mox $moy $moz" >> mol.xyz
        done
      fi
      #
    done
  done
done

#declare -a array=()
awk '{if(NR<=8){print $0}}' cluster.vasp > add_mol.vasp
cp cluster.vasp cluster_mol.vasp

teln=0
elements="H He Li Be B C N O F Ne Na Mg Al Si P S Cl Ar K Ca Sc Ti V Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr Rb Sr Y Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I Xe Cs Ba La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu Hf Ta W Re Os Ir Pt Au Hg Tl Pb Bi"
for el in $elements ; do
  nel=`grep -c $el mol.xyz`
  if [ "$nel" != "0" ]; then
    sel=`echo "$sel  $el"`
    eln=`echo "$eln  $nel"`
    teln=`echo "$teln+$nel" | bc`
    awk -v el=$el '{if($1==el){printf "%s  %s  %s \n",$2,$3,$4}}' mol.xyz >> add_mol.vasp
    awk -v el=$el '{if($1==el){printf "%s  %s  %s \n",$2,$3,$4}}' mol.xyz >> cluster_mol.vasp
  fi  
done
echo "$teln"
echo "$sel | $eln"
#
sed -i -e "1i $teln" mol.xyz
sed -i -e "2i $sel $eln" mol.xyz
#
sed -i -e "6c $sel" add_mol.vasp
sed -i -e "7c $eln" add_mol.vasp
#
sed -i -e "6 s/$/$sel/" cluster_mol.vasp
sed -i -e "7 s/$/$eln/" cluster_mol.vasp

echo "If same element is exist, please rewrite cluster_mol.vasp with cluster.vasp and mol.xyz"

#sed -i 's/$/\r/g' cluster.vasp # Linux (LF) -> Windows (CRLF)
