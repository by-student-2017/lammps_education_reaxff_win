#!/usr/bin/python3.8

import sys
import os
import math
from random import random, randint, sample
import numpy as np
import multiprocessing as mp
from datetime import datetime

number_parallel = int(3)
lammps="/home/ilia/bin/lmp_mpi"

STRUCTURES_ISIF3 = ["Mo_bcc", "S8_rh", "MoS_NaCl", "Mo3S4", "Mo2S3", "MoS2", "MoS2_1T", "MoS2_MQ_1", "MoS2_MQ_2", "MoS2_MQ_3", "MoS2_MQ_4", "MoS2_MQ_5", "MoS2_MQ_6", "MoS2_MQ_1_new", "MoS2_MQ_2_new", "MoS2_MQ_3_new", "MoS2_MQ_4_new", "MoS2_MQ_5_new", "MoS2_MQ_6_new", "MoS2_MQ_7_new", "MoS2_MQ_8_new", "MoS2_MQ_9_new", "MoS2_MQ_10_new", "MoS2_MQ_11_new", "MoS2_MQ_12_new", "MoS2_MQ_13_new"]
STRUCTURES_ISIF2 = []
STRUCTURES_FORCES = ["MoS2_MQ_1_forces", "MoS2_MQ_2_forces", "MoS2_MQ_3_forces", "MoS2_MQ_4_forces", "MoS2_MQ_5_forces", "MoS2_MQ_6_forces", "MoS2_MQ_7_forces", "MoS2_MQ_8_forces", "MoS2_MQ_9_forces", "MoS2_MQ_10_forces", "MoS2_MQ_11_forces", "MoS2_MQ_12_forces", "MoS2_MQ_13_forces", "MoS2_MQ_14_forces"]

now = datetime.now()
current_time = now.strftime("%H:%M:%S")

f123 = open("output",'w')
f123.write("Time start: " + str(current_time) + "\n")
f123.close()

def getlast(array):

    return array[-1]

def run_ISIF3(structure):

    os.system("rm -rf %s"%(structure))
    os.system("mkdir %s"%(structure))
    os.system("cp ffield.reax %s/ffield.reax"%(structure))
    os.system("cp %s.input %s/MoS.input"%(structure,structure))
    os.system("cp in.MoS_cryst_opt.lmp %s/."%(structure))
    directory = os.getcwd()
    os.chdir("%s/%s"%(directory,structure))
    os.system("%s < in.MoS_cryst_opt.lmp > out.MoS_opt.lmp"%(lammps))
    os.system("cp out.MoS_opt.lmp ../out.%s_opt.lmp"%(structure))
    os.system("cp MoS.lmp ../%s.lmp"%(structure))
    os.system("cp MoS.data ../%s.data"%(structure))
    os.chdir("%s"%(directory))
    os.system("rm -rf %s"%(structure))
    f1 = open("%s.lmp"%(structure),'r')
    coords = f1.read()
    f1.close()
    f2 = open("out.%s_opt.lmp"%(structure),'r')
    out_file = f2.read()
    f2.close()
    out_file = out_file.splitlines()
    energy = float(0.0)
    i = int(0)
    while ( i < int(len(out_file)) ):
        if ( out_file[i] != "" ):
            out_file[i] = out_file[i].split()
            if ( out_file[i][0] == "Energy" ):
                out_file[i+1] = out_file[i+1].split()
                energy = float(out_file[i+1][2])
                i = int(len(out_file))
        i=i+1
    coords = coords.splitlines()
    number_atoms = int(coords[3])
    f3 = open("%s"%(structure),'w')
    f3.write(str(number_atoms) + "\n")
    for i in range(0,number_atoms+4):
        f3.write(coords[-(number_atoms+4-i)] + "\n")
    f3.write(str(energy))
    f3.close()

    return structure

def run_ISIF2(structure):

    os.system("rm -rf %s"%(structure))
    os.system("mkdir %s"%(structure))
    os.system("cp ffield.reax %s/ffield.reax"%(structure))
    os.system("cp %s.input %s/MoS.input"%(structure,structure))
    os.system("cp in.MoS_mol_opt.lmp %s/."%(structure))
    directory = os.getcwd()
    os.chdir("%s/%s"%(directory,structure))
    os.system("%s < in.MoS_mol_opt.lmp > out.MoS_opt.lmp"%(lammps))
    os.system("cp out.MoS_opt.lmp ../out.%s_opt.lmp"%(structure))
    os.system("cp MoS.lmp ../%s.lmp"%(structure))
    os.system("cp MoS.data ../%s.data"%(structure))
    os.chdir("%s"%(directory))
    os.system("rm -rf %s"%(structure))
    f1 = open("%s.lmp"%(structure),'r')
    coords = f1.read()
    f1.close()
    f2 = open("out.%s_opt.lmp"%(structure),'r')
    out_file = f2.read()
    f2.close()
    out_file = out_file.splitlines()
    energy = float(0.0)
    i = int(0)
    while ( i < int(len(out_file)) ):
        if ( out_file[i] != "" ):
            out_file[i] = out_file[i].split()
            if ( out_file[i][0] == "Energy" ):
                out_file[i+1] = out_file[i+1].split()
                energy = float(out_file[i+1][2])
                i = int(len(out_file))
        i=i+1
    coords = coords.splitlines()
    number_atoms = int(coords[3])
    f3 = open("%s"%(structure),'w')
    f3.write(str(number_atoms) + "\n")
    for i in range(0,number_atoms+4):
        f3.write(coords[-(number_atoms+4-i)] + "\n")
    f3.write(str(energy))
    f3.close()

    return structure

def run_forces(structure):

    os.system("rm -rf %s"%(structure))
    os.system("mkdir %s"%(structure))
    os.system("cp ffield.reax %s/ffield.reax"%(structure))
    os.system("cp %s.input %s/MoS.input"%(structure,structure))
    os.system("cp in.MoS_forces.lmp %s/."%(structure))
    directory = os.getcwd()
    os.chdir("%s/%s"%(directory,structure))
    os.system("%s < in.MoS_forces.lmp > out.MoS_opt.lmp"%(lammps))
    os.system("cp out.MoS_opt.lmp ../out.%s_opt.lmp"%(structure))
    os.system("cp MoS.lmp ../%s.lmp"%(structure))
    os.chdir("%s"%(directory))
    os.system("rm -rf %s"%(structure))
    f1 = open("%s.lmp"%(structure),'r')
    coords = f1.read()
    f1.close()
    coords = coords.splitlines()
    number_atoms = int(coords[3])
    f2 = open("%s_DFT"%(structure),'r')
    forces_DFT = f2.read()
    f2.close()
    f3 = open("%s"%(structure),'w')
    f3.write(str(number_atoms) + "\n")
    for i in range(0,number_atoms):
        f3.write(coords[-(number_atoms-i)] + "\n")
    f3.write(forces_DFT)
    f3.close()

    return structure

def calc_func(array):

    ffield_new = []

    for i in range(0,ffield_length):
        ffield_new_line = []
        ffield_new_line = ffield_start[i]
        for j in range(0,number_params):
            if ( i == (int(params_all[j][0]) - 1) ):
                ffield_new_line[int(params_all[j][1])] = round(array[j],4)
        ffield_new.append(ffield_new_line)

    f33 = open("ffield.reax",'w')
    for i in range(0,ffield_length):
        for j in range(0,int(len(ffield_new[i]))):
            f33.write(str(ffield_new[i][j]) + "  ")
        f33.write("\n")
    f33.close()

    pool = mp.Pool(number_parallel)
    c = pool.map(run_ISIF3,[structure for structure in STRUCTURES_ISIF3])
    pool.close()

    f123 = open("output",'a')
    f123.write(str("ISIF3 done") + "\n")
    f123.close()

    pool = mp.Pool(number_parallel)
    c = pool.map(run_ISIF2,[structure for structure in STRUCTURES_ISIF2])
    pool.close()

    f123 = open("output",'a')
    f123.write(str("ISIF2 done") + "\n")
    f123.close()

    pool = mp.Pool(number_parallel)
    c = pool.map(run_forces,[structure for structure in STRUCTURES_FORCES])
    pool.close()

    f123 = open("output",'a')
    f123.write(str("forces done") + "\n")
    f123.close()

#    os.system("./script.opt.lmp")
    os.system("./error_calc.py")
    f11 = open("total_error",'r')
    error_total = f11.read()
    f1.close
    output = float(error_total)

    os.system("rm -rf out.*.lmp")

    return output


f1 = open("params_all", 'r')
params_all = f1.read()
f1.close

f2 = open("ffield_start", 'r')
ffield_start = f2.read()
f2.close()

ffield_start = ffield_start.splitlines()
ffield_length = int(len(ffield_start))
for i in range(0,int(len(ffield_start))):
    ffield_start[i] = ffield_start[i].split()

params = []
params_all = params_all.splitlines()
number_params = int(len(params_all))
for i in range(0,number_params):
    params_all[i] = params_all[i].split() # line, number, step, min, max 
#    params_all[i].append(float(ffield_start[int(params_all[i][0])-1][int(params_all[i][1])]))
    params.append(float(ffield_start[int(params_all[i][0])-1][int(params_all[i][1])]))

function_value = calc_func(params)
params.append(function_value)

now = datetime.now()
current_time = now.strftime("%H:%M:%S")

f123 = open("output",'a')
f123.write("Time: " + str(current_time) + "\n")
f123.close()

os.system("mv error_log error_log_start")

params_best = []
for i in range(0,int(len(params))):
    params_best.append(params[i])

f123 = open("output",'a')
for i in range(0,int(len(params))):
    f123.write(str("%.4f"%(params[i])) + "  ")
f123.write("\n")
f123.close()

counter_max = 50
step = float(4.0)
counter = int(0)
counter_unaccepted = int(0)
number_best = int(0)
f_param = float(0.2) 
while ( counter < counter_max ):
    params_old = []
    for i in range(0,int(len(params))):
        params_old.append(params[i])

    params_run = []
    for i in range(0,int(len(params))):
        params_run.append(params[i])

    number_change = randint(1,int(number_params/3))
    k = sample(range(0,number_params),number_change)
    for i in range(0,number_change):
        while ( params_run[k[i]] == params_old[k[i]] ):
            move_param = step*(random()-0.5)*abs(params_run[k[i]])*float(params_all[k[i]][2])
            if ( move_param > 0.0001 ):
                params_run[k[i]] = params_run[k[i]] + move_param
            else:
                params_run[k[i]] = params_run[k[i]] + move_param*0.0001/abs(move_param)
            if ( params_run[k[i]] > float(params_all[k[i]][4]) ):
                params_run[k[i]] = float(params_all[k[i]][4])
            if ( params_run[k[i]] < float(params_all[k[i]][3]) ):
                params_run[k[i]] = float(params_all[k[i]][3])
            f123 = open("output",'a')
            f123.write(str("%d"%(i)) + "  " + str("%d"%(k[i])) + "  " + str("%.4f"%(params_run[k[i]])) + "  " + str("%.4f"%(params_old[k[i]])) + "\n")
            f123.close()
    function_value = calc_func(params_run)
    os.system("cp ffield.reax ffield_%d"%(counter))
    os.system("mv error_log error_log_%d"%(counter))
    params_run[-1] = function_value
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    
    f123 = open("output",'a')
    f123.write(str("%d"%(counter)) + "  " + str("%d"%(counter_unaccepted)) + "  " + str("%.4f"%(step)) + "\n")
    for i in range(0,int(len(params_run))):
        f123.write(str("%.4f"%(params_run[i])) + "  ")
    f123.write("\n")
    f123.write("Time: " + str(current_time) + "\n")
    f123.close()

    if ( params_run[-1] < params_best[-1] ):
        params_best = []
        for i in range(0,int(len(params_run))):
            params_best.append(params_run[i])

        f123 = open("output",'a')
        f123.write("\n")
        f123.write("New best set at step %d: %s"%(counter,params_run[-1]) + "\n")
        for i in range(0,int(len(params_best))):
            f123.write(str("%.4f"%(params_best[i])) + "  ")
        f123.write("\n")
        f123.close()
        step = float(1)
        number_best = counter

        params = []
        for i in range(0,int(len(params_run))):
            params.append(params_run[i])
        counter_unaccepted = int(0)
        step = min(float(4.0),step*2)
        counter = counter + 1

    elif ( params_run[-1] < params_old[-1] ):
        f123 = open("output",'a')
        f123.write("\n")
        f123.write("step: " + str("%d"%(counter)) + "  " + str("%.4f"%(params_run[-1])))
        f123.write("\n")
        f123.close()
        params = []
        for i in range(0,int(len(params_run))):
            params.append(params_run[i])
        counter_unaccepted = int(0)
        step = min(float(4.0),step*2)
        counter = counter + 1

    else:
        dice = random()
        if ( dice > (params_run[-1] - params_best[-1])/(f_param*(counter_max-counter)*abs(params_best[-1])/(counter_max)) ):
            f123 = open("output",'a')
            f123.write("\n")
            f123.write("step: " + str("%d"%(counter)) + "  " + str("%.4f"%(params_run[-1])))
            f123.write("\n")
            f123.close()
            params = []
            for i in range(0,int(len(params_run))):
                params.append(params_run[i])
            counter_unaccepted = int(0)
            step = min(float(4.0),step*2)
            counter = counter + 1
        else:
            params = []
            for i in range(0,int(len(params_old))):
                params.append(params_old[i])
            counter_unaccepted = counter_unaccepted + 1
            step = step/2

    if ( step < 0.001 ):
        params = []
        for i in range(0,int(len(params_best))):
            params.append(params_best[i])
        step = float(1)

    if ( counter_unaccepted > 15 ):
        f123 = open("output",'a')
        f123.write("parameters don't move" + "\n")
        f123.close()
        counter = 200000

    if ( params_best[-1] < 0.01 ):
        counter = 200000
        f123 = open("output",'a')
        f123.write("Minimum reached" + "\n")
        f123.close()

f123 = open("output",'a')
for i in range(0,int(len(params_best))):
    f123.write(str("%.4f"%(params_best[i])) + "  ")
f123.close()
