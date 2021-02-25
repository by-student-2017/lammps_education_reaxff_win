#For placing Li such that it is within Rmin and Rmax distance from Si atom.
def getRandCoords(flag,n_id,rmin,rmax,lmpptr):
    import random
    from mpi4py import MPI
    from lammps import lammps
    lmp = lammps(ptr=lmpptr)
    comm = MPI.COMM_WORLD
    me = comm.Get_rank()
    nprocs = comm.Get_size()
    itermax = 100000
    natoms = lmp.get_natoms()
    coords = lmp.gather_atoms("x",1,3)
    typ = lmp.gather_atoms("type",0,1)
    boxlo,boxhi,xy,yz,xz,periodicity,box_change = lmp.extract_box()
    n_gc = lmp.extract_variable("n_GCMC", 0, 0)
    iSiDist = lmp.extract_variable("iSiDist", 0, 0)                 #addon1   #1:to place new atom such that rmin< disminSi <rmax
    iNear1 = lmp.extract_variable("iNear1", 0, 0)                   #addon2.1 #1:to place near Si
    typeNear1 = lmp.extract_variable("typeNear1", 0, 0)                       #atom type of Si
    iNear2 = lmp.extract_variable("iNear2", 0, 0)                   #addon2.2 #1:to place near Si or Li
    typeNear2 = lmp.extract_variable("typeNear2", 0, 0)                       #atom type of Li
    iparticle = lmp.extract_variable("iparticle", 0, 0)             #addon3   #1:to place in particle
    far_atoms = lmp.extract_variable("far_atoms", 0, 0)
    far_rfact = lmp.extract_variable("far_rfact", 0, 0)
    if me == 0:
        #box dim and non-gc atoms
        lx = boxhi[0]-boxlo[0]
        ly = boxhi[1]-boxlo[1]
        lz = boxhi[2]-boxlo[2]
        n_nongc = natoms - int(round(n_gc))
        #get indices of all atoms and delete the index of the atom that is to be displaced (if any)
        indices=range(natoms)
        if (flag):
            del indices[(n_id-1)]
        ##for i in range(natoms):
        ##    print i+1, typ[i], coords[3*i], coords[3*i+1], coords[3*i+2]
        #find com and radius of particle
        xcm=ycm=zcm=0
        part_indices = []
        for i in range(n_nongc):
            if typ[i]==typeNear1:                #It is considered that the atom type of particle are same as typeNear1
                xcm = xcm + coords[3*i]     
                ycm = ycm + coords[3*i+1]
                zcm = zcm + coords[3*i+2]
                part_indices.append(i)
        n_part=len(part_indices)
        xcm = xcm/n_part
        ycm = ycm/n_part
        zcm = zcm/n_part
        far_part_atoms = int(round(far_atoms))                           #No. of farthest atoms from COM whose avg dist from COM to be considered for radius of particle calc
        far_r_factor = far_rfact                       #Calc avg radius^2 of r_atoms will be multiplied by this factor (<1 to be conservative)            
        rsq = []                                    #list of squared radial distances of atoms in particle from COM of particle
        for i in part_indices:                      #It is considered that the atom type of particle are same as typeNear
            dx = coords[3*i] - xcm
            dy = coords[3*i+1] - ycm
            dz = coords[3*i+2] - zcm
            rsq.append(dx*dx + dy*dy + dz*dz)
        rsq_part = (sum(sorted(rsq)[-far_part_atoms:])/far_part_atoms)*far_r_factor
        print "No. of particle atoms, COM and radius^2 of particle are: ", n_part, xcm, ycm, zcm, rsq_part
        #define criteria variable with high and false values so that the loop is entered
        rminsq=rmin*rmin
        rmaxsq=rmax*rmax
        distminsq = 100000000        #for default-criteria
        distminSisq = 100000000      #for addon-criteria1
        typedistmin = 0              #for addon-criteria2
        rsq_gc = 10000000            #for addon-criteria3   #Distance of new gcmc atom from particle com
        if iNear2==0:
            typeNear2=typeNear1
        iter = 0
        while (not((distminsq >= rminsq) and (distminsq <= rmaxsq) \
                and (distminSisq*iSiDist >= rminsq*iSiDist) and (distminSisq*iSiDist <= rmaxsq*iSiDist) \
                and ((typedistmin*iNear1 == typeNear1*iNear1) or (typedistmin*iNear1 == typeNear2*iNear1)) \
                and (rsq_gc*iparticle <= rsq_part*iparticle) )):
            iter = iter +1
            if (iter>itermax):
                break
            distminsq = 100000000
            distminSisq = 100000000
            rx = boxlo[0]+random.random()*lx
            ry = boxlo[1]+random.random()*ly
            rz = boxlo[2]+random.random()*lz
            rsq_gc = (rx-xcm)*(rx-xcm) + (ry-ycm)*(ry-ycm) + (rz-zcm)*(rz-zcm)
            for i in indices:
                distx=min(abs(rx-coords[3*i]), lx-abs(rx-coords[3*i]))
                disty=min(abs(ry-coords[3*i+1]), ly-abs(ry-coords[3*i+1]))
                distz=min(abs(rz-coords[3*i+2]), lz-abs(rz-coords[3*i+2]))
                distsq = distx*distx + disty*disty + distz*distz
                if (distsq<distminsq):
                    distminsq=distsq
                    typedistmin=typ[i]
                if (typ[i]==typeNear1 and distsq<distminSisq):
                    distminSisq=distsq
        if (flag):
            rx = rx - coords[3*(n_id-1)]
            ry = ry - coords[3*(n_id-1)+1]
            rz = rz - coords[3*(n_id-1)+2]
    else:
        rx= ry= rz= frx= fry= frz= distminsq= distminSisq= typedistmin= rsq_gc= rsq_part= iter= None
    rx = comm.bcast(rx,root=0)
    ry = comm.bcast(ry,root=0)
    rz = comm.bcast(rz,root=0)
    frx=lmp.set_variable("rx",rx)
    fry=lmp.set_variable("ry",ry)
    frz=lmp.set_variable("rz",rz)
    iter = comm.bcast(iter,root=0)
    if me==0:
        print 'In getcoord.py (iter, coords(3), distminsq, distminSisq, typedistmin, rsq_gc, rsq_part:', iter, rx, ry, rz, distminsq, distminSisq, typedistmin, rsq_gc, rsq_part
    if (iter <= itermax):
        return 1
    else:
        return 0
