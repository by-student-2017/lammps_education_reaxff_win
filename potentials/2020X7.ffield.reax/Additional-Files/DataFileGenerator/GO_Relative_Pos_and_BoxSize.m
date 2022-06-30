function  [dx,dy,dz,Box_Size]=GO_Relative_Pos_and_BoxSize(Sim_Type,N_Layers,a_0_CP,XY_Pristine,r_cc,d_x,d_y,d_z,L_x,L_y,L_z,Hwall,Xwall)
 dx=zeros(1,N_Layers);                                      
 dy=zeros(1,N_Layers); 
 dz=zeros(1,N_Layers);

if Sim_Type==3
%the wall is vertical so I need to calculate the number of unitcells that
%fit in the wall
%the distance between layers is modified so we can make sure about the
%interlayer spacing
N_uc_z_wall=floor(N_Layers*d_z/a_0_CP(1,1));
d_z_mod=N_uc_z_wall*a_0_CP(1,1)/N_Layers;
Box_Size=[Xwall,-Xwall+max(XY_Pristine(:,4));min(XY_Pristine(:,4)),max(XY_Pristine(:,4))+r_cc*sqrt(3)/2;-d_z_mod/2,N_Layers*d_z_mod-d_z_mod/2];
for i=2:N_Layers;  dz(1,i)=(i-1)*d_z_mod; end

 
end

 
 
end