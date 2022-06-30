function [Box_Size,d_z]=BoxSize(Sim_Type,N_Layers,a_0_CP,XY_Pristine,r_cc,del_x,del_y,del_z,L_x,L_y,L_z,dx,dy,dz,Hwall,Xwall)


if (Sim_Type==0)                %interlayer spacing no water
Box_Size=[min(XY_Pristine(:,3)),max(dx(1,:))+max(XY_Pristine(:,3))+r_cc;min(XY_Pristine(:,4)),max(XY_Pristine(:,4))+r_cc*sqrt(3)/2;-del_z/2,N_Layers*del_z-del_z/2];
elseif (Sim_Type==1)            %interlayer spacing with water
Box_Size=[min(XY_Pristine(:,3)),max(dx(1,:))+max(XY_Pristine(:,3))+r_cc;min(XY_Pristine(:,4)),max(XY_Pristine(:,4))+r_cc*sqrt(3)/2;-del_z/2,N_Layers*del_z-del_z/2];
elseif (Sim_Type==2)            %filtration, horizental
m=ceil((L_x*9+r_cc+8*d_x)/(3*r_cc));
Box_Size=[-eps,m*a_0_CP(1,1)+eps;min(XY_Pristine(:,4)),max(XY_Pristine(:,4))+r_cc*sqrt(3)/2;-Hwall,Hwall];    
elseif (Sim_Type==3)            %filtration, vertical
%the wall is vertical so I need to calculate the number of unitcells that
%fit in the wall
%the distance between layers is modified so we can make sure about the
%interlayer spacing
N_uc_z_wall=floor(N_Layers*del_z/a_0_CP(1,1));
del_z_mod=N_uc_z_wall*a_0_CP(1,1)/N_Layers;
Box_Size=[-Xwall,Xwall+max(XY_Pristine(:,4));min(XY_Pristine(:,4)),max(XY_Pristine(:,4))+r_cc*sqrt(3)/2;-del_z_mod/2,N_Layers*del_z_mod-del_z_mod/2];
for i=2:N_Layers;  dz_mod(1,i)=(i-1)*del_z_mod; end
elseif (Sim_Type==4)            %adsorption

end




end