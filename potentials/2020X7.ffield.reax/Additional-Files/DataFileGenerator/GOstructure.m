clear
%Type: 
%1: C Pristine (CpB)
%2: C in Carboxyl base (CC1)
%3: C in Carboxyl High (CC2)
%4: C in Epoxy Bridge (CE)
%5: C in Hydroxyl (CH)
%6: C in Wall (CW)
%7: O in Carboxyl single branch  (OC1)
%8: O in Carboxyl with Hydrogen (OC2)
%9: O in Epoxy Bridge (OE)
%10: O in Hydroxyl (OH)
%11: O in water (OW)
%12: O in deuterated water (OD)
%13: H in Carboxyl (HC)
%14: H in Hydroxyl (HH)
%15: H in Water (HW)
%16: H in deuterated water (HD)
%17: C Pristine edge (CpE)


  for Q1=1:1  %counter on Epoxy
     for Q2=1:1  %counter on try
     savedir0= pwd; savedir=[savedir0 '/'];
     %Fraction of Epoxyl, Hydroxyl and Carboxyl
     N_try0=[1];
     f_Epoxyl0=[0];
     f_Hydroxyl0=[0.3];
  
         MoleculTypeGO=1;
         %Charge of atoms
         %q=[CpB,CC1, CC2,  CE,  CH,CW,  OC1,  OC2,    OE,   OH,      OW,   OD,   HC,    HH,   HW,  HD,CpE]
         q=[0,    0,0.29,0.14,0.15, 0,-0.14,-0.585,-0.28,-0.585,-0.8476,-0.87,0.435,0.435,0.4238,0.435,0];
         %mass=[   CpB,    CC1,    CC2,     CE,     CH,     CW,    OC1,    OC2,     OE,     OH,     OW,     OD,      HC,      HH,    HW,       HD,   CpE]
         mass=[12.0107,12.0107,12.0107,12.0107,12.0107,12.0107,15.9994,15.9994,15.9994,15.9994,15.9994,15.9994,1.00794,1.00794,1.00794,2.0141018,12.0107];
         mass_C=mass(1,1);  mass_O=mass(1,7);  mass_H=mass(1,13);  mass_D=mass(1,16);  mass_H2O=mass_O+2*mass_H;  mass_D2O=mass_O+2*mass_D;
         
    
N_try=N_try0(1,Q2);
f_Epoxyl=f_Epoxyl0(1,Q1);       
f_Hydroxyl=f_Hydroxyl0(1,1);      
f_Carboxyl=0;                               %Fraction on the edge atoms only;
Double=1;                                   %0 not Double sided, 1 Double sided


%Type of simulation
%Filtering_Vertical=3(With wall, With Water Out, Periodic
Sim_Type=3;
periodicity=1;                              %if we have periodic boundary condition, periodicity==1

%Relative position of the GO sheets
D_H2O_GO=2;                                 %safty distance between the water molecules and GO membranes
D_W_between_Layers=3;
water_weight_fraction=3;                    %weight fraction of the water 
f_D2O=0.5;                                  %weight fraction of the water that is heavy water



%Carbon in Pristine plane
H=0;                                                        %height of the layer
r_CPB_CPB=1.4;                  
a_0_CP=[3,sqrt(3),0].*r_CPB_CPB;
type_C_Pristine=[1,1,1,1];
Basis_CP=[1/6,0.0,0.0;
          3/6,0.0,0.0;
          0.0,1/2,0.0;
          4/6,1/2,0.0];
 
      
%Layers size    
N_ucX=6;                                                    %Number of unitcells in X direction
N_ucY=10;                                                    %Number of unitcells in Y direction
N_holes=0;                                                  %Number of holes

X_P=[1].*r_CPB_CPB;                                             %coordinate and radius of porosity (units in unitcells)
Y_P=[sqrt(3)/2].*r_CPB_CPB;
R_P=[2.5].*r_CPB_CPB;

%Expanding the strucutre (Pristine plane)
PristineAtoms=expand(a_0_CP,Basis_CP,N_ucX,N_ucY,H);

%Making porosity in the structure
for j=1:N_holes
PristineAtoms=porosity(PristineAtoms,X_P(1,j),Y_P(1,j),R_P(1,j));
end
[N_Cp,c]=size(PristineAtoms);
[N_SoFar,c]=size(PristineAtoms);
XY_Pristine(1:N_Cp,1)=1:N_Cp;                                   %Atoms number
XY_Pristine(1:N_Cp,2)=1;                                        %type of prisitine atoms
XY_Pristine(1:N_Cp,3:5)=PristineAtoms;                          %position of pristine atoms



 %relative displacement of the layers of GO 
 N_Layers=6;       %if interlayer spacing or vertical filtration N-layers is 5  

    
L_x=max(PristineAtoms(:,1))-min(PristineAtoms(:,1));                  %Length of a sheet in x direction
L_y=max(PristineAtoms(:,2))-min(PristineAtoms(:,2));                  %Length of a sheet in y direction
L_z=0;

%distance between the sheets in direfernt directions
del_x=3;
del_y=0;
del_z=9.11;

%Position of the wall
Hwall=50+del_z;
Xwall=min(XY_Pristine(:,1))-50;

%function for finding the displacement applyed to each sheet of GO and Determining the box size
[dx,dy,dz,Box_Size]=GO_Relative_Pos_and_BoxSize(Sim_Type,N_Layers,a_0_CP,XY_Pristine,r_CPB_CPB,del_x,del_y,del_z,L_x,L_y,L_z,Hwall,Xwall);


%The cut off distance is the maximum cell size +1 A for safty factor
COD=max(a_0_CP(1,1:3))+1;                                         
EXTENDED_CP = neighbGO(COD, Box_Size(1,1), Box_Size(1,2), Box_Size(2,1), Box_Size(2,2), Box_Size(3,1), Box_Size(3,2), XY_Pristine);

%if I do not have periodic boundary condition, The extended atoms are the
%same as initial atoms
if (periodicity ==0)
EXTENDED_CP=XY_Pristine;
end

%list of neighbourng atoms in the pristine plane (we use it later on for
%avoiding neighbouring hydroxyls
N_N_Pris0=Neib_List(EXTENDED_CP,XY_Pristine,r_CPB_CPB);
N_N_Pris(:,1)=1:size(N_N_Pris0(:,1));
N_N_Pris=[N_N_Pris,N_N_Pris0];
%seprating edge and bulk atoms 
Bulk=EdgeOrBulk(XY_Pristine,EXTENDED_CP,r_CPB_CPB);
[N_Bulk,c]=size(Bulk);
Edge=zeros(1,5);
all_Pristine=zeros(1,N_Cp);     %all atoms in the prestine. We sign zero to it
for i=1:N_Bulk
  all_Pristine(1,Bulk(i,1))=1;  %if it is in the bulk, we assign 1 to it means it is not at the edge
end
counter=0;
IDEXTENDED=EXTENDED_CP(:,1);
for i=1:N_Cp
    if all_Pristine(1,i)==0
      counter=counter+1;
      XY_Pristine(i,2)=17;
      EXTENDED_CP(IDEXTENDED==XY_Pristine(i,1),2)=17;
      Edge(counter,1:5)=XY_Pristine(i,1:5);  %if it is in the bulk, we assign 1 to it means it is not at the edge
      
    end
    
end
[N_Edge,c]=size(Edge); [N_Bulk,c]=size(Bulk);
if Edge(1,1)==0; N_Edge=0; end;

%at this point all Carbon atoms are potentially available for accepting a
%functional group
Available_C_Atoms=1:N_Cp; Available_C_Atoms=Available_C_Atoms';
if N_Edge~=0
Available_C_Atoms(Edge(:,1),2)=0;  %Edge atoms are available
end
Available_C_Atoms(Bulk(:,1),2)=1;  %Bulk atoms are available
%Making the list of the Epoxy atoms
if f_Epoxyl>0
[Epoxy,list]=BondForEpoxy(XY_Pristine,EXTENDED_CP,r_CPB_CPB,Available_C_Atoms,f_Epoxyl,Double,r_CPB_CPB,N_SoFar,H);
[N_Epoxy,c]=size(Epoxy);
N_SoFar=N_SoFar+N_Epoxy;
M=Available_C_Atoms(:,2); N=list(:,2);
List_Cp_Epoxy=list(M==1 & N==0);                %Carbon pristine atoms with the epoxy bond
else
N_Epoxy=0;
list=Available_C_Atoms;
end

Available_C_Atoms=list;


%Bonds in Carboxyl
r_CC1_CC2=1.472;  r_CC2_OC1=1.23;  r_CC2_OC2=1.37;    r_OC2_HC=0.96;      %Angestrom
r_CARBOXYL=[r_CC1_CC2,r_CC2_OC1,r_CC2_OC2,r_OC2_HC];

%Angles in Carboxyl
T_CC1_CC2_OC1=120; T_CC1_CC2_OC2=120;  T_CC2_OC2_HC=112;                    %Degree
Teta_CARBOXYL=[T_CC1_CC2_OC1,T_CC1_CC2_OC2,T_CC2_OC2_HC];

%Making Carboxyls
N_a_Car=4;              %Number of atoms in a Carboxyl unit
if (N_Edge~=0 & f_Carboxyl>0)
%list of available atoms
AVAILABLE=Edge(:,1); %only edge atoms are available for carboxyl
N_CARB=floor(f_Carboxyl*N_Edge);      %Number of Carboxyl groups
N2Choose=N_CARB;
k=1;
   while N2Choose>0
         i = AVAILABLE(randi(length(AVAILABLE)),1);  %Choosing a atom randomly from the main list
         AVAILABLE(AVAILABLE==i,:)=[];
         list(i,2)=0;
         X=XY_Pristine(i,3);    Y=XY_Pristine(i,4);    Z=XY_Pristine(i,5);
        [TYPE_C,COOR_CARBOXYL0]=Carboxyl(X,Y,Z,r_CARBOXYL,Teta_CARBOXYL,Double,H);
        for p=1:N_a_Car
            CARBOXYL((k-1)*N_a_Car+p,1)=N_SoFar+(k-1)*N_a_Car+p;
            CARBOXYL((k-1)*N_a_Car+p,2)=TYPE_C(1,p);
            CARBOXYL((k-1)*N_a_Car+p,3:5)=COOR_CARBOXYL0(p,1:3);
            if p==1 
                CARBOXYL((k-1)*N_a_Car+p,6)=i; 
            elseif (p==2 || p==4)
                CARBOXYL((k-1)*N_a_Car+p,6)=N_SoFar+(k-1)*N_a_Car+p-1;
            else
                CARBOXYL((k-1)*N_a_Car+p,6)=N_SoFar+(k-1)*N_a_Car+p-2;
            end
                
        end
        List_Cp_Carboxyl(k,1)=list(i,1);
        k=k+1;
        N2Choose=N2Choose-1;
   end
     
end

if (N_Edge~=0 & f_Carboxyl>0)
[N_Carb,c]=size(CARBOXYL);
else
    N_Carb=0;
end
    
N_SoFar=N_SoFar+N_Carb;
   
%Bonds in Hydroxyl
r_CH_OH=1.35;   r_OH_HH=0.96;      %Angestrom
r_HYDROXYL=[r_CH_OH,r_OH_HH];

%Angles in Hydroxyl
T_Cp_OH_HH=109;                     %Degree

%Making Hydroxyl
N_a_Hyd=2;              %Number of atoms in a Hydroxyl unit
if f_Hydroxyl>0
AVAILABLE0=list(:,2);  %list of available atoms
AVAILABLE=list(AVAILABLE0>0,1);
%nearest neighbour list in pristine that are available
N_N_Pris=N_N_Pris(AVAILABLE0>0,:);
ID_Pristine=N_N_Pris(:,1);
%available prisitne atoms to accept hydroxyl in the positive side of the
%plane
AVAILABLE_P=AVAILABLE;
%available prisitne atoms to accept hydroxyl in the negative side of the
%plane
AVAILABLE_N=AVAILABLE;

N_HYD=floor(f_Hydroxyl*N_Cp);      %Number of Hydroxyl groups
N2Choose=N_HYD;
k=1;

%Making Hydroxyl
   while N2Choose>0
        if Double==1; sign=(-1)^(randi([1,2],1,1)); else; sign=1; end
        %Choosing a atom randomly from the main list of positive if the hydroxyle will be in the upper side
        if sign==1 %sign is 1, hysroxyl in positive side
            i=AVAILABLE_P(randi(length(AVAILABLE_P)),1);
            Row_N=find(ID_Pristine==i);
            AVAILABLE(AVAILABLE==i,:)=[]; %the main atom is deleted from all three lists
            AVAILABLE_P(AVAILABLE_P==i,:)=[];
            AVAILABLE_N(AVAILABLE_N==i,:)=[];
             % all the neighbours are eliminated too
            for p=1:N_N_Pris(Row_N,2)
            AVAILABLE_P(AVAILABLE_P==N_N_Pris(Row_N,2+p),:)=[];
            end
            
        else %sign is -1, hysroxyl in negative side
            i=AVAILABLE_N(randi(length(AVAILABLE_N)),1);
            Row_N=find(ID_Pristine==i);
            AVAILABLE(AVAILABLE==i,:)=[]; %the main atom is deleted from all three lists
            AVAILABLE_P(AVAILABLE_P==i,:)=[];
            AVAILABLE_N(AVAILABLE_N==i,:)=[];
            % all the neighbours are eliminated too
            for p=1:N_N_Pris(Row_N,2)
            AVAILABLE_N(AVAILABLE_N==N_N_Pris(Row_N,2+p),:)=[];
            end
        end
  
         list(i,2)=0;
         X=XY_Pristine(i,3);    Y=XY_Pristine(i,4);    Z=XY_Pristine(i,5);
        [TYPE_C,COOR_HYDOXYL0]=Hydroxyl(X,Y,Z,r_HYDROXYL,T_Cp_OH_HH,sign);
        
        for p=1:N_a_Hyd
            HYDOXYL((k-1)*N_a_Hyd+p,1)=N_SoFar+(k-1)*N_a_Hyd+p;
            HYDOXYL((k-1)*N_a_Hyd+p,2)=TYPE_C(1,p);
            HYDOXYL((k-1)*N_a_Hyd+p,3:5)=COOR_HYDOXYL0(p,1:3);
            if p==1 
                HYDOXYL((k-1)*N_a_Hyd+p,6)=i; 
               else
                HYDOXYL((k-1)*N_a_Hyd+p,6)=N_SoFar+(k-1)*N_a_Hyd+p-1;
            end
                
        end
        List_Cp_Hydroxyl(k,1)=list(i,1);
        k=k+1;
        N2Choose=N2Choose-1;

   end
   
end


if ( f_Hydroxyl>0)
[N_Hyd,c]=size(HYDOXYL);
else
    N_Hyd=0;
end

N_SoFar=N_SoFar+N_Hyd;

%Changing the type of the base atoms for different functional groups
A = exist('List_Cp_Carboxyl','var');
if (A(1,1)>0); XY_Pristine(List_Cp_Carboxyl,2)=2; end;
A = exist('List_Cp_Epoxy','var');
if (A(1,1)>0); XY_Pristine(List_Cp_Epoxy,2)=4; end;
A = exist('List_Cp_Hydroxyl','var');
if (A(1,1)>0); XY_Pristine(List_Cp_Hydroxyl,2)=5; end;


%PLot the structure if you want to observe
% figure
% plot3(EXTENDED_CP(:,3),EXTENDED_CP(:,4),EXTENDED_CP(:,5),'o')
% hold on
% plot3(XY_Pristine(:,3),XY_Pristine(:,4),XY_Pristine(:,5),'r*')
% if N_Epoxy~=0
% plot3(Epoxy(:,3),Epoxy(:,4),Epoxy(:,5),'rs')
% end
% if N_Carb~=0
% plot3(CARBOXYL(:,3),CARBOXYL(:,4),CARBOXYL(:,5),'black*')
% end
% if N_Hyd~=0
% plot3(HYDOXYL(:,3),HYDOXYL(:,4),HYDOXYL(:,5),'r*')
% end


%Adding q and molecul type to the pristine atoms-in case that the atom type
%is full (it will not be used for the charge case)

N1=1;N2=N_Cp;
atoms(N1:N2,1)=XY_Pristine(:,1); %place holder 
atoms(N1:N2,3)=XY_Pristine(:,2); atoms(N1:N2,2)=MoleculTypeGO; atoms(N1:N2,4)=q(1,atoms(1:end,3));  atoms(N1:N2,5:7)=XY_Pristine(:,3:5);    atoms(N1:N2,8:10)=0;

if N_Epoxy~=0
N1=N_Cp+1;N2=N_Cp+N_Epoxy;
atoms(N1:N2,1)=Epoxy(:,1);  
atoms(N1:N2,3)=Epoxy(:,2); atoms(N1:N2,2)=MoleculTypeGO; atoms(N1:N2,4)=q(1,atoms(N1:N2,3)); atoms(N1:N2,5:7)=Epoxy(:,3:5);  atoms(N1:N2,8:10)=0;
end

if N_Carb~=0
N1=N_Cp+N_Epoxy+1;N2=N_Cp+N_Epoxy+N_Carb;
atoms(N1:N2,1)=CARBOXYL(:,1);  
atoms(N1:N2,3)=CARBOXYL(:,2); atoms(N1:N2,2)=MoleculTypeGO; atoms(N1:N2,4)=q(1,atoms(N1:N2,3));  atoms(N1:N2,5:7)=CARBOXYL(:,3:5);    atoms(N1:N2,8:10)=0;
end
if N_Hyd~=0
N1=N_Cp+N_Epoxy+N_Carb+1;N2=N_Cp+N_Epoxy+N_Carb+N_Hyd;
atoms(N1:N2,1)=HYDOXYL(:,1);  
atoms(N1:N2,3)=HYDOXYL(:,2); atoms(N1:N2,2)=MoleculTypeGO; atoms(N1:N2,4)=q(1,atoms(N1:N2,3));  atoms(N1:N2,5:7)=HYDOXYL(:,3:5);    atoms(N1:N2,8:10)=0;
end


r_CE_OE=1.32;
r_CPB_CC1=1.4; r_CPB_CE=1.4; r_CPB_CH=1.4; r_CPB_CPE=1.4; r_CC1_CC1=1.4; r_CC1_CE=1.4; r_CC1_CH=1.4; r_CC1_CPE=1.4; r_CE_CE=1.4; r_CE_CH=1.4; r_CE_CPE=1.4; r_CH_CPE=1.4; r_CH_CH=1.4;
r_CW_CW=1.4;   r_CPE_CPE=1.4;   
      
       
%one layer of G_O 
%atoms 
atoms_GO=atoms;
EXTENDED_GO = neighbGO(COD, Box_Size(1,1), Box_Size(1,2), Box_Size(2,1), Box_Size(2,2), Box_Size(3,1), Box_Size(3,2), atoms_GO(:,[1 3 5:7]));

%Replicate atoms
replica_atom=atoms_GO;

for i=2:N_Layers;atoms_GO=REPLICA_ATOMS(atoms_GO,replica_atom,dx,dy,dz,i);end

Type_GO_iLayer=replica_atom(:,3);
%number of oxygen atoms in one GO layer
N_O_GO=size(replica_atom(Type_GO_iLayer>6 & Type_GO_iLayer<11),1);
%number of Hydrogen atoms in one GO layer 
N_H_GO=size(replica_atom(Type_GO_iLayer==13 | Type_GO_iLayer==14),1);
%number of Carbon atoms in one GO layer 
N_C_GO=size(replica_atom,1)-N_O_GO-N_H_GO;


%numeber of GO atoms and molecules
N_Molecules_Sofar=max(atoms_GO(:,2));
N_atoms_Sofar=max(atoms_GO(:,1));


%if there is a wall in the strucure, we cunstruct it

if Sim_Type==3       %wall for water filtration Vertical  
    N_ucZ_wall=floor(N_Layers*(dz(1,2)-dz(1,1))/a_0_CP(1,1));
    N_ucY_wall=N_ucY;
    WallAtoms0=expand(a_0_CP,Basis_CP,N_ucZ_wall,N_ucY_wall,Xwall);
    %switch the wall to yz plan
    temparary=WallAtoms0(:,1);
    WallAtoms0(:,1)=WallAtoms0(:,3);
    WallAtoms0(:,3)=temparary;
    displaceVector=min(WallAtoms0(:,3))-Box_Size(3,1);
    WallAtoms0(:,3)=WallAtoms0(:,3)-displaceVector+eps;

    
    N_Wall=size(WallAtoms0,1);
    C_Wall_Type=6;
    atoms_wall(1:N_Wall,1)=N_atoms_Sofar+1:N_atoms_Sofar+N_Wall;
    atoms_wall(1:N_Wall,2)=N_Molecules_Sofar+1;
    atoms_wall(1:N_Wall,3)=C_Wall_Type;
    atoms_wall(1:N_Wall,4)=q(1,C_Wall_Type);
    atoms_wall(1:N_Wall,5:7)=WallAtoms0;
    atoms_wall(1:N_Wall,8:10)=0;
    
    N_Molecules_Sofar=max(atoms_wall(:,2));
    N_atoms_Sofar=max(atoms_wall(:,1));
    
end


if Sim_Type==3       %vertical filtration
    % if the water molecules are not betweeen the layers (for the case of
    % filteration)
    mass_GO_All=N_Layers*(N_O_GO*mass_O+N_C_GO*mass_C+N_H_GO*mass_H);
    N_H2O=floor(mass_GO_All/mass_H2O*(1-f_D2O))*water_weight_fraction;
    N_D2O=N_H2O;
    Box_water_Filter=[Box_Size(1,1),min(atoms_GO(:,4));Box_Size(2,1),Box_Size(2,2);Box_Size(3,1),Box_Size(3,2)];   %domain of the water for folteration
    atoms_water=WATER_Filtertion(N_H2O,N_D2O,Box_water_Filter,D_H2O_GO,del_z,q,N_Molecules_Sofar,N_atoms_Sofar);
end



    N_Molecules_Sofar=max(atoms_water(:,2));
    N_atoms_Sofar=max(atoms_water(:,1));


%merging aotms  
AtomList=atoms_GO;
if (Sim_Type==2 | Sim_Type==3);AtomList=[AtomList;atoms_wall]; end  
if (Sim_Type==1 | Sim_Type==2 | Sim_Type==3);AtomList=[AtomList;atoms_water]; end



FileName=['GOTwoSide' num2str(Sim_Type) 'type'  num2str(f_D2O) 'fraction' num2str(f_Carboxyl) 'Car' num2str(f_Hydroxyl) 'Hyd'  num2str(f_Epoxyl) 'Epo'  num2str(N_try) 'Try.data'];
DataMaker(savedir,AtomList,FileName,a_0_CP,Box_Size)
clearvars -except Q1 Q2     
     end
 end