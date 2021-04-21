#!/usr/bin/env python

# make new dump file from final snapshots from multiple NEB replica dumps
# Syntax: neb_final.py -switch arg(s) -switch arg(s) ...
#         -o outfile = new dump file
#            snapshots numbered 1 to M = # of replicas
#         -r dump1   = replica dump files of NEB atoms
#         -n number of dump file

import sys,os
#path = os.environ["LAMMPS_PYTHON_TOOLS"]
#sys.path.append(path)
#from dump import dump

# parse args

outfile = ""
#backfile = ""
rfiles = []

argv = sys.argv
iarg = 1
narg = len(argv)
while iarg < narg:
  if argv[iarg] == "-o":
    outfile = argv[iarg+1]
    iarg += 2
  #elif argv[iarg] == "-b":
  #  backfile = argv[iarg+1]
  #  iarg += 2
  elif argv[iarg] == "-r":
    ilast = iarg + 1
    while ilast < narg and argv[ilast][0] != '-': ilast += 1
    rfiles = argv[iarg+1:ilast]
    iarg = ilast
  elif argv[iarg] == "-n":
    nif = int(argv[iarg+1])
    print(nif)
    iarg += 2
  else: break

if iarg < narg or not outfile or not rfiles:
  #print ("Syntax: neb_final.py -o outfile -b backfile -r dump1 dump2 ...")
  print ("Syntax: neb_final.py -o outfile -r dump1 -n 4")
  sys.exit()

if os.path.exists(outfile): os.remove(outfile)

# nback = additional atoms in each snapshot

#if backfile:
#  back = dump(backfile)
#  t = back.time()
#  back.tselect.one(t[-1])
#  nback = back.snaps[-1].nselect
#else: nback = 0

# write out each snapshot
# time = replica #
# natoms = ntotal, by overwriting nselect
# add background atoms if requested

fileobj = open(outfile,"a")
#n = 1
#for file in rfiles:
for n in range(nif):
  file = "".join(rfiles)
  #print(file)
  nfile = file.replace('*', str(n+1))
  print(nfile)
  with open(nfile) as f:
    for i, line in enumerate(f):
      if 'ITEM: TIMESTEP' in line:
        timstep_final_line = i
    print(timstep_final_line)
  with open(nfile) as f:
    lines = f.readlines()[timstep_final_line:]
    nlines = "".join(lines)
    fileobj.write(nlines)
  #neb = dump(file)
  #t = neb.time()
  #neb.tselect.one(t[-1])
  #hold = neb.snaps[-1].nselect
  #neb.snaps[-1].nselect = hold + nback
  #neb.snaps[-1].time = n
  #neb.write(outfile,1,1)
  #neb.snaps[-1].nselect = hold
  #if backfile: back.write(outfile,0,1)
  #n += 1

import re
filene = open("out_energy.txt","a")
title = "RDx(position) PE(Energy) \n"
filene.write(title)
def readlines_file(file_name):
    with open(file_name, 'r') as file:
        return file.readlines()
lines = readlines_file("log.lammps")
slines = str(lines[-1 * int(1):])
for n in range(nif):
  print(re.split(" +", slines)[9+2*n:11+2*n])
  nslines = " ".join(re.split(" +", slines)[9+2*n:11+2*n])
  filene.write(nslines+"\n")
#print("".join(lines[-1 * int(1):]))