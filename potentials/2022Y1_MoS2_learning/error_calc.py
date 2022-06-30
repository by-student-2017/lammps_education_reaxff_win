#!/usr/bin/python

import sys
import math
import os
from fractions import Fraction

f1 = open("trainset", 'r')

trainset   = f1.read()

f1.close()

total_error = float(0.0)

trainset = trainset.splitlines()
lines_trainset = int(len(trainset))
i=0
while ( i < lines_trainset ):
    trainset_line = trainset[i]
    trainset_line = trainset_line.split()
    if ( trainset_line[0] == "ENERGY" ):
        error_mode = "ENERGY" 
    if ( trainset_line[0] == "CELL" ):
        error_mode = "CELL"
    if ( trainset_line[0] == "FORCE" ):
        error_mode = "FORCE"
    if ( trainset_line[0] == "BONDS" ):
        error_mode = "BONDS"
    if ( trainset_line[0] == "ANGLES" ):
        error_mode = "ANGLES"
    if ( trainset_line[0] == "CHARGES" ):
        error_mode = "CHARGES"
    if ( trainset_line[0] != "ENERGY" and trainset_line[0] != "CELL" and trainset_line[0] != "FORCE" and trainset_line[0] != "BONDS" and trainset_line[0] != "ANGLES" and trainset_line[0] != "CHARGES" ):
        if ( error_mode == "ENERGY" ):
            j=1
            k=0
            structure = []
            coeff     = []
            arg_number = int(len(trainset_line))
            weight_line = float(trainset_line[0])
            while ( j < arg_number-1 ):
                structure.append(trainset_line[j])
                coeff.append(trainset_line[j+1])
                coeff[k] = float(Fraction(coeff[k]))
                j = j + 2
                k = k + 1
            true_value = float(trainset_line[arg_number-1])
            l=0
            energy_diff = float(0.0)
            while ( l < k ):
                f2 = open(structure[l])
                data_structure = f2.read()
                f2.close()
                data_structure = data_structure.split()
                last_number = int(len(data_structure)) - 1
                data_structure[last_number] = float(data_structure[last_number])
                energy_diff = energy_diff + data_structure[last_number]*coeff[l]
                
                l = l + 1

            total_error = total_error + weight_line*(energy_diff-true_value)*(energy_diff-true_value)/(0.4*0.4)
            f3 = open("error_log", 'a')
            f3.write(trainset[i]) 
            f3.write("   ")
            f3.write(str("%.4f"%(energy_diff))) 
            f3.write("   ") 
            f3.write(str("%.4f"%(weight_line*(energy_diff-true_value)*(energy_diff-true_value)/(0.4*0.4))))
            f3.write("   ") 
            f3.write(str("%.f4"%(total_error)))
            f3.write("\n")
            f3.close()

            

        if ( error_mode == "CELL" ):
           weight_line = float(trainset_line[0])
           structure = trainset_line[1]
           cell_param = trainset_line[2]
           true_value = float(trainset_line[3])
           if ( cell_param == "a" ):
               f2 = open(structure)
               data_structure = f2.read()
               f2.close()
               data_structure = data_structure.split()
               p_lo = float(data_structure[1]) - min( 0.0, float(data_structure[3]), float(data_structure[6]), float(data_structure[3])+float(data_structure[6]))
               p_hi = float(data_structure[2]) - max( 0.0, float(data_structure[3]), float(data_structure[6]), float(data_structure[3])+float(data_structure[6]))
               cell_param_value = p_hi - p_lo
           if ( cell_param == "b" ):
               f2 = open(structure)
               data_structure = f2.read()
               f2.close()
               data_structure = data_structure.split()
               p_lo = float(data_structure[4]) - min(0.0, float(data_structure[9]))
               p_hi = float(data_structure[5]) - max(0.0, float(data_structure[9]))
               cell_param_value = p_hi - p_lo
           if ( cell_param == "c" ):
               f2 = open(structure)
               data_structure = f2.read()
               f2.close()
               data_structure = data_structure.split()
               cell_param_value = float(data_structure[8]) - float(data_structure[7])
           total_error = total_error + weight_line*(cell_param_value-true_value)*(cell_param_value-true_value)/(0.01*0.01)
           f3 = open("error_log", 'a')
           f3.write(trainset[i])
           f3.write("   ")
           f3.write(str("%.3f"%(cell_param_value)))
           f3.write("   ")
           f3.write(str("%.4f"%(weight_line*(cell_param_value-true_value)*(cell_param_value-true_value)/(0.01*0.01))))
           f3.write("   ")
           f3.write(str("%.4f"%(total_error)))
           f3.write("\n")
           f3.close()

        if ( error_mode == "BONDS" ):
            weight_line = float(trainset_line[0])
            structure = trainset_line[1]
            atom1 = int(trainset_line[2])
            atom2 = int(trainset_line[3])
            true_value = float(trainset_line[4])
            f2 = open(structure)
            data_structure = f2.read()
            f2.close()
            data_structure = data_structure.splitlines()
            coords_atom1 = data_structure[atom1+4].split()
            coords_atom2 = data_structure[atom2+4].split()
            x_local = float(coords_atom1[3]) - float(coords_atom2[3])
            y_local = float(coords_atom1[4]) - float(coords_atom2[4]) 
            z_local = float(coords_atom1[5]) - float(coords_atom2[5])

            cell_line1 = data_structure[1].split()
            cell_line2 = data_structure[2].split()
            cell_line3 = data_structure[3].split()

            cell_xx = float(cell_line1[1]) - float(cell_line1[0]) - max( 0.0 , float(cell_line1[2]) , float(cell_line2[2]) , float(cell_line2[2])+float(cell_line1[2]) ) + min( 0.0 , float(cell_line1[2]) , float(cell_line2[2]) , float(cell_line2[2])+float(cell_line1[2]) )
            cell_yx = float(0.0)
            cell_zx = float(0.0)
            cell_xy = float(cell_line1[2])
            cell_yy = float(cell_line2[1]) - float(cell_line2[0]) - max(0.0, float(cell_line3[2])) + min(0.0, float(cell_line3[2]))
            cell_zy = float(0.0)
            cell_xz = float(cell_line2[2])
            cell_yz = float(cell_line3[2])
            cell_zz = float(cell_line3[1]) - float(cell_line3[0])

            cell_determ = cell_xx*cell_yy*cell_zz

            inv_xx =  (cell_yy*cell_zz)/cell_determ
            inv_yx =  float(0.0)
            inv_zx =  float(0.0)
            inv_xy = -(cell_xy*cell_zz)/cell_determ
            inv_yy =  (cell_xx*cell_zz)/cell_determ
            inv_zy =  float(0.0)
            inv_xz =  (cell_xy*cell_yz-cell_xz*cell_yy)/cell_determ
            inv_yz = -(cell_xx*cell_yz)/cell_determ
            inv_zz =  (cell_xx*cell_yy)/cell_determ

            x_local_direct = x_local*inv_xx + y_local*inv_yx + z_local*inv_zx
            if ( x_local_direct > 0.5 ):
                x_local_direct = x_local_direct - 1.0
            if ( x_local_direct < -0.5 ):
                x_local_direct = x_local_direct + 1.0

            y_local_direct = x_local*inv_xy + y_local*inv_yy + z_local*inv_zy
            if ( y_local_direct > 0.5 ):
                y_local_direct = y_local_direct - 1.0
            if ( y_local_direct < -0.5 ):
                y_local_direct = y_local_direct + 1.0

            z_local_direct = x_local*inv_xz + y_local*inv_yz + z_local*inv_zz
            if ( z_local_direct > 0.5 ):
                z_local_direct = z_local_direct - 1.0
            if ( z_local_direct < -0.5 ):
                z_local_direct = z_local_direct + 1.0

            x_local = x_local_direct*cell_xx + y_local_direct*cell_yx + z_local_direct*cell_zx
            y_local = x_local_direct*cell_xy + y_local_direct*cell_yy + z_local_direct*cell_zy
            z_local = x_local_direct*cell_xz + y_local_direct*cell_yz + z_local_direct*cell_zz

            distance_atoms = math.sqrt(x_local*x_local + y_local*y_local + z_local*z_local)
            total_error = total_error + weight_line*(distance_atoms-true_value)*(distance_atoms-true_value)/(0.01*0.01)
            f3 = open("error_log", 'a')
            f3.write(trainset[i])
            f3.write("   ")
            f3.write(str("%.3f"%(distance_atoms)))
            f3.write("   ")
            f3.write(str("%.4f"%(weight_line*(distance_atoms-true_value)*(distance_atoms-true_value)/(0.01*0.01))))
            f3.write("   ")
            f3.write(str("%.4f"%(total_error)))
            f3.write("\n")
            f3.close()

        if ( error_mode == "ANGLES" ):
            weight_line = float(trainset_line[0])
            structure = trainset_line[1]
            atom1 = int(trainset_line[2])
            atom2 = int(trainset_line[3])
            atom3 = int(trainset_line[4])
            true_value = float(trainset_line[5])
            f2 = open(structure)
            data_structure = f2.read()
            f2.close()
            data_structure = data_structure.splitlines()
            coords_atom1 = data_structure[atom1+4].split()
            coords_atom2 = data_structure[atom2+4].split()
            coords_atom3 = data_structure[atom3+4].split()
            x1_local = float(coords_atom1[3]) - float(coords_atom2[3])
            y1_local = float(coords_atom1[4]) - float(coords_atom2[4])
            z1_local = float(coords_atom1[5]) - float(coords_atom2[5])
            x2_local = float(coords_atom3[3]) - float(coords_atom2[3])
            y2_local = float(coords_atom3[4]) - float(coords_atom2[4])
            z2_local = float(coords_atom3[5]) - float(coords_atom2[5])

            cell_line1 = data_structure[1].split()
            cell_line2 = data_structure[2].split()
            cell_line3 = data_structure[3].split()

            cell_xx = float(cell_line1[1]) - float(cell_line1[0]) - max( 0.0, float(cell_line1[2]), float(cell_line2[2]), float(cell_line2[2])+float(cell_line1[2]) ) + min( 0.0, float(cell_line1[2]), float(cell_line2[2]), float(cell_line2[2])+float(cell_line1[2]) )
            cell_yx = float(0.0)
            cell_zx = float(0.0)
            cell_xy = float(cell_line1[2])
            cell_yy = float(cell_line2[1]) - float(cell_line2[0]) - max(0.0, float(cell_line3[2])) + min(0.0, float(cell_line3[2]))
            cell_zy = float(0.0)
            cell_xz = float(cell_line2[2])
            cell_yz = float(cell_line3[2])
            cell_zz = float(cell_line3[1]) - float(cell_line3[0])

            cell_determ = cell_xx*cell_yy*cell_zz

            inv_xx =  (cell_yy*cell_zz)/cell_determ
            inv_yx =  float(0.0)
            inv_zx =  float(0.0)
            inv_xy = -(cell_xy*cell_zz)/cell_determ
            inv_yy =  (cell_xx*cell_zz)/cell_determ
            inv_zy =  float(0.0)
            inv_xz =  (cell_xy*cell_yz-cell_xz*cell_yy)/cell_determ
            inv_yz = -(cell_xx*cell_yz)/cell_determ
            inv_zz =  (cell_xx*cell_yy)/cell_determ

            x1_local_direct = x1_local*inv_xx + y1_local*inv_yx + z1_local*inv_zx
            if ( x1_local_direct > 0.5 ):
                x1_local_direct = x1_local_direct - 1.0
            if ( x1_local_direct < -0.5 ):
                x1_local_direct = x1_local_direct + 1.0

            y1_local_direct = x1_local*inv_xy + y1_local*inv_yy + z1_local*inv_zy
            if ( y1_local_direct > 0.5 ):
                y1_local_direct = y1_local_direct - 1.0
            if ( y1_local_direct < -0.5 ):
                y1_local_direct = y1_local_direct + 1.0

            z1_local_direct = x1_local*inv_xz + y1_local*inv_yz + z1_local*inv_zz
            if ( z1_local_direct > 0.5 ):
                z1_local_direct = z1_local_direct - 1.0
            if ( z1_local_direct < -0.5 ):
                z1_local_direct = z1_local_direct + 1.0

            x1_local = x1_local_direct*cell_xx + y1_local_direct*cell_yx + z1_local_direct*cell_zx
            y1_local = x1_local_direct*cell_xy + y1_local_direct*cell_yy + z1_local_direct*cell_zy
            z1_local = x1_local_direct*cell_xz + y1_local_direct*cell_yz + z1_local_direct*cell_zz

            x2_local_direct = x2_local*inv_xx + y2_local*inv_yx + z2_local*inv_zx
            if ( x2_local_direct > 0.5 ):
                x2_local_direct = x2_local_direct - 1.0
            if ( x2_local_direct < -0.5 ):
                x2_local_direct = x2_local_direct + 1.0

            y2_local_direct = x2_local*inv_xy + y2_local*inv_yy + z2_local*inv_zy
            if ( y2_local_direct > 0.5 ):
                y2_local_direct = y2_local_direct - 1.0
            if ( y2_local_direct < -0.5 ):
                y2_local_direct = y2_local_direct + 1.0

            z2_local_direct = x2_local*inv_xz + y2_local*inv_yz + z2_local*inv_zz
            if ( z2_local_direct > 0.5 ):
                z2_local_direct = z2_local_direct - 1.0
            if ( z2_local_direct < -0.5 ):
                z2_local_direct = z2_local_direct + 1.0

            x2_local = x2_local_direct*cell_xx + y2_local_direct*cell_yx + z2_local_direct*cell_zx
            y2_local = x2_local_direct*cell_xy + y2_local_direct*cell_yy + z2_local_direct*cell_zy
            z2_local = x2_local_direct*cell_xz + y2_local_direct*cell_yz + z2_local_direct*cell_zz

            cosangle_atoms = (x1_local*x2_local + y1_local*y2_local + z1_local*z2_local)/(math.sqrt(x1_local*x1_local + y1_local*y1_local + z1_local*z1_local)*math.sqrt(x2_local*x2_local + y2_local*y2_local + z2_local*z2_local))
            angle_atoms = math.acos(cosangle_atoms)*180.0/3.14159265359
            total_error = total_error + weight_line*(angle_atoms-true_value)*(angle_atoms-true_value)
            f3 = open("error_log", 'a')
            f3.write(trainset[i])
            f3.write("   ")
            f3.write(str("%.2f"%(angle_atoms)))
            f3.write("   ")
            f3.write(str("%.4f"%(weight_line*(angle_atoms-true_value)*(angle_atoms-true_value))))
            f3.write("   ")
            f3.write(str("%.4f"%(total_error)))
            f3.write("\n")
            f3.close()

        if ( error_mode == "CHARGES" ):
            weight_line = float(trainset_line[0])
            structure = trainset_line[1]
            atom1 = int(trainset_line[2])
            true_value = float(trainset_line[3])
            f2 = open(structure)
            data_structure = f2.read()
            f2.close()
            data_structure = data_structure.splitlines()
            coords_atom1 = data_structure[atom1+4].split()
            charge_atom1 = float(coords_atom1[2])
            total_error = total_error + weight_line*(charge_atom1-true_value)*(charge_atom1-true_value)/(0.01*0.01)
            f3 = open("error_log", 'a')
            f3.write(trainset[i])
            f3.write("   ")
            f3.write(str("%.3f"%(charge_atom1)))
            f3.write("   ")
            f3.write(str("%.4f"%(weight_line*abs(charge_atom1-true_value)/(0.01*0.01))))
            f3.write("   ")
            f3.write(str("%.4f"%(total_error)))
            f3.write("\n")
            f3.close()

        if ( error_mode == "FORCE" ):
            weight_line = float(trainset_line[0])
            structure = trainset_line[1]
            f2 = open(structure)
            forces = f2.read()
            f2.close()
            forces = forces.split()
            forces[0] = int(forces[0])*3
            error_forces = float(0.0) 
            j=0
            while ( j < forces[0] ):
                j = j+1
                if ( float(forces[j+forces[0]]) != 0 ):
                    error_forces = error_forces + weight_line*(float(forces[j])-float(forces[j+forces[0]])*23.0609)*(float(forces[j])-float(forces[j+forces[0]])*23.0609)/(0.1*0.1)
            total_error = total_error + error_forces
            f3 = open("error_log", 'a')
            f3.write(trainset[i])
            f3.write("   ")
            f3.write(str("%.4f"%(error_forces)) + "   " + str("%.4f"%(total_error)))
            f3.write("\n")
            f3.close()
            
           
    i = i + 1

from datetime import datetime
now = datetime.now()
current_time = now.strftime("%H:%M:%S")
f3 = open("error_log", 'a')
f3.write(str(current_time) + "\n")
f3.close()

f4 = open("total_error", 'w')
f4.write(str(total_error))
f4.write("\n")
f4.close()
