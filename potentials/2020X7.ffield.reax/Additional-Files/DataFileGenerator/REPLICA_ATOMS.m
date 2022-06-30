function Particles=REPLICA_ATOMS(Particles,REPEATING,dx,dy,dz,counter)
%replicate the GO atoms

    X0=REPEATING(:,5);
    Y0=REPEATING(:,6);
    Z0=REPEATING(:,7);
    N_Sofar=size(Particles,1);
    REPEATING(:,1)=N_Sofar+1:(N_Sofar+size(REPEATING,1));
    REPEATING(:,2)=counter;
    REPEATING(:,5)=X0+dx(1,counter);
    REPEATING(:,6)=Y0+dy(1,counter);
    REPEATING(:,7)=Z0+dz(1,counter);
    Particles=[Particles;REPEATING];
    
    
end