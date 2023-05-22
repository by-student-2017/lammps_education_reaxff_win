#!/usr/bin/env python

# This file reads in the file log.lammps generated by the script ELASTIC/in.elastic
# It prints out the 6x6 tensor of elastic constants Cij 
# followed by the 6x6 tensor of compliance constants Sij
# It uses the same conventions as described in:
# Sprik, Impey and Klein PRB (1984).  
# The units of Cij are whatever was used in log.lammps (usually GPa)
# The units of Sij are the inverse of that (usually 1/GPa)

from numpy import zeros
from numpy.linalg import inv

# define logfile layout

nvals = 21
valpos = 4
valstr = '\nElastic Constant C'

# define order of Cij in logfile

cindices = [0]*nvals
cindices[0] = (0,0)
cindices[1] = (1,1)
cindices[2] = (2,2)
cindices[3] = (0,1)
cindices[4] = (0,2)
cindices[5] = (1,2)
cindices[6] = (3,3)
cindices[7] = (4,4)
cindices[8] = (5,5)
cindices[9] = (0,3)
cindices[10] = (0,4)
cindices[11] = (0,5)
cindices[12] = (1,3)
cindices[13] = (1,4)
cindices[14] = (1,5)
cindices[15] = (2,3)
cindices[16] = (2,4)
cindices[17] = (2,5)
cindices[18] = (3,4)
cindices[19] = (3,5)
cindices[20] = (4,5)

# open logfile

logfile = open("log.lammps",'r')

txt = logfile.read()

# search for 21 elastic constants

c = zeros((6,6))
s2 = 0

for ival in range(nvals):
    s1 = txt.find(valstr,s2)
    if (s1 == -1):
        print ("Failed to find elastic constants in log file")
        exit(1)
    s1 += 1
    s2 = txt.find("\n",s1)
    line = txt[s1:s2]
#    print line
    words = line.split()
    (i1,i2) = cindices[ival]
    c[i1,i2] = float(words[valpos])
    c[i2,i1] = c[i1,i2]

print(" ", end="\n") 
print ("C tensor [GPa] (elastic stiffness constants)")
for j in range(6):
    print (" %10i      " % (j+1), end=" ")
print(" ", end="\n")
for i in range(6):
    print ("%i" % (i+1), end="")
    for j in range(6):
        print (" %15.8g " % c[i][j], end=" ")
    print(" ", end="\n")
        
# apply factor of 2 to columns of off-diagonal elements

for i in range(6):
    for j in range(3,6):
        c[i][j] *= 2.0
        
s = inv(c)

# apply factor of 1/2 to columns of off-diagonal elements

for i in range(6):
    for j in range(3,6):
        s[i][j] *= 0.5

print(" ", end="\n")     
print ("S tensor [1/GPa] (elastic compliance constants)")
for j in range(6):
    print (" %10i      " % (j+1), end=" ")
print(" ", end="\n")
for i in range(6):
    print ("%i" % (i+1), end="")
    for j in range(6):
        print (" %15.8g " % s[i][j], end=" ")
    print(" ", end="\n")
        

print(" ", end="\n")

cpc = c[0][1] - c[3][3] # C12 - C44
print ("Cauchy pressure (C12 - C44) for cubic structure: %15.8g" % cpc, end="\n")
cph = c[0][2] - c[3][3] # C13 - C44
print ("Cauchy pressure (C13 - C44) for hexagonal structure: %15.8g" % cph, end="\n")
print ("Cauchy pressure (C13 - C44) for tetragonal structure: %15.8g" % cph, end="\n")
cpt = c[0][1] - c[5][5] # C12 - C66
print ("Cauchy pressure (C12 - C66) for tetragonal structure: %15.8g" % cpt, end="\n")

print(" ", end="\n")
print("Ref: F. M. Gao and L. H. Gao, Journal of Superhard Materials, 2010, Vol. 32, No. 3, pp. 148-166.", end="\n")

print(" ", end="\n")

BV = (c[0][0]+c[1][1]+c[2][2])/9 + 2*(c[0][1]+c[0][2]+c[1][2])/9
BR = 1/((s[0][0]+s[1][1]+s[2][2]) + 2*(s[0][1]+s[0][2]+s[1][2]))
B  = (BV + BR)/2

print ("Voigt bulk modulus, BV: %15.8g " % BV, end="\n")
print ("Reuss bulk modulus, BR: %15.8g " % BR, end="\n")
print ("Hill bulk modulus, B=(BV+BR)/2: %15.8g [GPa]" % B,  end="\n")

print(" ", end="\n")

GV = (c[0][0]+c[1][1]+c[2][2]-c[0][1]-c[0][2]-c[1][2])/15 + (c[3][3]+c[4][4]+c[5][5])/5
GR = 15/(4*(s[0][0]+s[1][1]+s[2][2]) - 4*(s[0][1]+s[0][2]+s[1][2]) + 3*(s[3][3]+s[4][4]+s[5][5]))
G  = (GV + GR)/2

print ("Voigt shear modulus, GV: %15.8g " % GV, end="\n")
print ("Reuss shear modulus, GR: %15.8g " % GR, end="\n")
print ("Hill shear modulus, G=(GV+GR)/2: %15.8g [GPa]" % G,  end="\n")

print(" ", end="\n")

k = G/B
print ("Pughs modulus ratio, k=G/B: %15.8g" % k, end="\n")

print(" ", end="\n")

print("Voigt", end="\n")

HvTain = 0.92*((GV/BV)**1.137)*(GV**0.708)
print ("Vickers hardnesses (Tian  model, 2012): %15.8g [GPa]" % HvTain, end="\n")

HvChen = 2.0*((GV/BV)**2.0*GV)**0.585-3.0
print ("Vickers hardnesses (Chen  model, 2011): %15.8g [GPa]" % HvChen, end="\n")

HvTeter = 0.151*GV
print ("Vickers hardnesses (Teter model, 1998): %15.8g [GPa]" % HvTeter, end="\n")

print(" ", end="\n")

print("Reuss", end="\n")

HvTain = 0.92*((GR/BR)**1.137)*(GR**0.708)
print ("Vickers hardnesses (Tian  model, 2012): %15.8g [GPa]" % HvTain, end="\n")

HvChen = 2.0*((GR/BR)**2.0*GR)**0.585-3.0
print ("Vickers hardnesses (Chen  model, 2011): %15.8g [GPa]" % HvChen, end="\n")

HvTeter = 0.151*GR
print ("Vickers hardnesses (Teter model, 1998): %15.8g [GPa]" % HvTeter, end="\n")

print(" ", end="\n")

print("Hill", end="\n")

HvTain = 0.92*((G/B)**1.137)*(G**0.708)
print ("Vickers hardnesses (Tian  model, 2012): %15.8g [GPa]" % HvTain, end="\n")

HvChen = 2.0*((G/B)**2.0*G)**0.585-3.0
print ("Vickers hardnesses (Chen  model, 2011): %15.8g [GPa]" % HvChen, end="\n")

HvTeter = 0.151*G
print ("Vickers hardnesses (Teter model, 1998): %15.8g [GPa]" % HvTeter, end="\n")

print(" ", end="\n")

print("Note (VASP case)", end="\n")
print("Hill = Voigt-Reuss-Hill (VRH) Approximation (averages)", end="\n")
print("covalent and ionic crystals: Root Mean Square Error (RMSE) of HvChen = 4.4", end="\n")
print("covalent and ionic crystals: Mean Absolute Error (MAE) of HvChen = 2.1", end="\n")
print("bulk metallic glasses: Root Mean Square Error (RMSE) of HvChen = 0.9", end="\n")
print("bulk metallic glasses: Mean Absolute Error (MAE) of HvChen = 0.8", end="\n")

print("")
print("Attention")
print("  These expressions are optimized for first-principles calculations,")
print("the closer the potential is to the first-principles calculation (VASP, etc), ")
print("the closer to the above range of errors (Note (VASP case)).")
print("")
print("Note")
print("  Depending on the potential used, ")
print("these results can be evaluated qualitatively or semi-quantitatively for experimental results.")
print("")
print("Advanced information No.1")
print("  The prediction accuracy is improved by developing a potential that ")
print("gives results close to the first-principles calculation or calculating it using ")
print("Neural Network Molecular Dynamics (NNMD).")
print("")
print("Advanced information No.2")
print("  In an environment where VASP cannot be used or in a system where the calculation cost is ")
print("too high for first-principles calculation, someone has to develop the potential for Lammps.")
print("  I can't develop because I don't have research funds and post.")
print("  I hope someone will develop and publish EAM, MEAM, ADP, ReaxFF, NNMD, etc. for all element combinations. ")
print("  I can't do it anymore. Old soldiers like me who are close to the slave class just disappear.")
print("  Glory to young people living in the future !")
print("")
print("  There's no living with a killing (= no research funds and no post).")
print("  A beautiful world bids farewell and rides off into the valley of death,")
print('ignoring i desperate cries of "A true beautiful world, come back !"')
print("  Goodbye, a true beautiful world !")
print("  And then there were none.")