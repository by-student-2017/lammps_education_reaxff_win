function molecules=WATER_Filtertion(N_H2O,N_D2O,Box_Size,d_H2O_GO,D_Z,q,N_mol,N_at)

O=[0,0,0];
H1=[1,0,0];
Side_D=2;         %distance of water molecules from the side of the box
D_InterMolecul=3;
x_w_grid=Box_Size(1,1)+Side_D:D_InterMolecul:Box_Size(1,2)-Side_D;
y_w_grid=Box_Size(2,1)+Side_D:D_InterMolecul:Box_Size(2,2)-Side_D;
z_w_grid=Box_Size(3,1)+Side_D:D_InterMolecul:Box_Size(3,2)-Side_D;
[Possibel_x_w,Possibel_y_w,Possibel_z_w]=meshgrid(x_w_grid,y_w_grid,z_w_grid);

N_available=length(x_w_grid)*length(y_w_grid)*length(z_w_grid);
if (N_available<N_H2O+N_D2O)
    f_H2O=N_H2O/(N_H2O+N_D2O);
    f_D2O=1-f_H2O;
    N_H2O=floor(f_H2O*N_available);
    N_D2O=floor(f_D2O*N_available);
end

[H1_az,H1_el,H1_r]=cart2sph(H1(1,1),H1(1,2),H1(1,3));
tet=109.45;
H2=[cos(deg2rad(tet)),sin(deg2rad(tet)),0];
[H2_az,H2_el,H2_r]=cart2sph(H2(1,1),H2(1,2),H2(1,3));


%total number of water and heavy water molecules
N2Choose=N_H2O+N_D2O;
molecules=zeros(3*N2Choose,10);

%random orientation for H1 in spherical coordiante system
az1=rand(1,N2Choose).*2*pi;
el1=rand(1,N2Choose).*pi;

%random orientation for H2 in spherical coordiante system
az2=az1;  

%only the elaggetual angle needs to change 109 degree 
el2=el1+H2_az; 



%convert coordinate to cartezian (a random orientation for He atoms /
%Oxygen is in the (0,0,0) 
XYZ0_1=[cos(az1).*sin(el1); sin(az1).*sin(el1); cos(el1)]';
XYZ0_2=[cos(az2).*sin(el2); sin(az2).*sin(el2); cos(el2)]';

% Oxygen atoms are distributed randomly in the permited domain
p=randperm(numel(Possibel_x_w));  %randomly mix the cells with no repeating
pp=p(1:N2Choose);                %we choose cells to the number we need


% Oxygen atoms are distributed randomly in the permited domain
%randomly chosen x for the oxygen atom of the water
Xrand=Possibel_x_w(pp);
%Xrand=Box_Size(1,1)+rand(1,N2Choose).*(Box_Size(1,2)-Box_Size(1,1));
%randomly chosen y for the oxygen atom of the water
Yrand=Possibel_y_w(pp);
%Yrand=Box_Size(2,1)+rand(1,N2Choose).*(Box_Size(2,2)-Box_Size(2,1));
%randomly chosen z for the oxygen atom of the water
Zrand=Possibel_z_w(pp);
%Zrand=Box_Size(3,1)+rand(1,N2Choose).*(Box_Size(3,2)-Box_Size(3,1));



%transfering the H atoms to the neighbouring of the random position of the oxygen atoms  
X0_H1=XYZ0_1(:,1)+Xrand'; Y0_H1=XYZ0_1(:,2)+Yrand'; Z0_H1=XYZ0_1(:,3)+Zrand';
X0_H2=XYZ0_2(:,1)+Xrand'; Y0_H2=XYZ0_2(:,2)+Yrand'; Z0_H2=XYZ0_2(:,3)+Zrand';

O_position=[Xrand;Yrand;Zrand]';
H1_position=[X0_H1,Y0_H1,Z0_H1];
H2_position=[X0_H2,Y0_H2,Z0_H2];

p=0;
for i=1:N_H2O
    p=p+1;
    water(p,1:3)=O_position(i,:);
    water(p,4)=11;
    water(p,5)=q(1,water(p,4));
    p=p+1;
    water(p,1:3)=H1_position(i,:);
    water(p,4)=15;
    water(p,5)=q(1,water(p,4));
    p=p+1;
    water(p,1:3)=H2_position(i,:);
    water(p,4)=15;
    water(p,5)=q(1,water(p,4));
end

for i=N_H2O+1:N_D2O+N_H2O
    p=p+1;
    water(p,1:3)=O_position(i,:);
    water(p,4)=12;
    water(p,5)=q(1,water(p,4));
    p=p+1;
    water(p,1:3)=H1_position(i,:);
    water(p,4)=16;
    water(p,5)=q(1,water(p,4));
    p=p+1;
    water(p,1:3)=H2_position(i,:);
    water(p,4)=16;
    water(p,5)=q(1,water(p,4));
end




% V1=H1_position-O_position;
% V2=H2_position-O_position;

% for i=1:size(V1,1)
% r1(i,1)=norm(V1(i,1:3));
% r2(i,1)=norm(V2(i,1:3));
% end
%  for i=1:size(XYZ0_1,1)
%  Theta(i,1) = rad2deg(acos(dot(V1(i,1:3),V2(i,1:3))));
%  end





p=0;
for i=1:3*N_H2O
    p=p+1;
    q=ceil(p/3);
    molecules(p,1)=p;                                       %ID
    molecules(p,2)=q;                                       %molecule type
    molecules(p,3)=water(p,4);                              %atom type (Oxygen in water)
    molecules(p,4)=water(p,5);                              %atom charge (Oxygen in water)
    molecules(p,5:7)=water(p,1:3);                          %atom position X and Y and Z
    molecules(p,8:10)=0;                                   
                                                             
end


for i=1:3*N_D2O
    p=p+1;
    q=ceil(p/3);
    molecules(p,1)=p;                                       %ID
    molecules(p,2)=q;                                       %molecule type
    molecules(p,3)=water(p,4);                              %atom type (Oxygen in water)
    molecules(p,4)=water(p,5);                              %atom charge (Oxygen in water)
    molecules(p,5:7)=water(p,1:3);                          %atom position X and Y and Z
    molecules(p,8:10)=0;                                   
                                                            %atom position Z 
end
    
molecules(:,1)=molecules(:,1)+N_at;
molecules(:,2)=molecules(:,2)+N_mol;
end
