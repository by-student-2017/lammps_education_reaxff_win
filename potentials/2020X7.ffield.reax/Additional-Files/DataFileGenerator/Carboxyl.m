function [TYPE_C,COOR_CARBOXYL]=Carboxyl(X,Y,Z,r_CARBOXYL,Teta_CARBOXYL,double,H)
%2: C Carboxyl (C1)
%4: O the oxygen in the branch with Hydrogen (OH)
%5: H Hydrogen in the branch with Oxygen (HO)
%6: O the oxygen in the branch with no Hydrogen  (O1)


if double==1
sign=(-1)^(randi([1,2],1,1));
else
   sign=1;
end
%Bonds in Carboxyl
r_Cp_C1=r_CARBOXYL(1,1);
r_C1_O1=r_CARBOXYL(1,2);
r_C1_OH=r_CARBOXYL(1,3);
r_OH_HO=r_CARBOXYL(1,4);
%Angles in Carboxyl
T_Cp_C1_O1=Teta_CARBOXYL(1,1); 
T_Cp_C1_OH=Teta_CARBOXYL(1,2);  
T_C1_OH_HO=Teta_CARBOXYL(1,3); 

%C1
TYPE_C(1,1)=3;
COOR_CARBOXYL(1,1:3)=[X,Y,r_Cp_C1];

%O1
TYPE_C(1,2)=7;
COOR_CARBOXYL(2,1:3)=[X-r_C1_O1*cos(degtorad(T_Cp_C1_O1)-pi/2),Y,r_Cp_C1+r_C1_O1*sin(degtorad(T_Cp_C1_O1)-pi/2)];

%OH
TYPE_C(1,3)=8;
COOR_CARBOXYL(3,1:3)=[X+r_C1_OH*cos(degtorad(T_Cp_C1_OH)-pi/2),Y,r_Cp_C1+r_C1_OH*sin(degtorad(T_Cp_C1_OH)-pi/2)];

%HO
TYPE_C(1,4)=13;
COOR_CARBOXYL(4,1:3)=[X+r_C1_OH*cos(degtorad(T_Cp_C1_OH)-pi/2),Y,r_Cp_C1+r_C1_OH*sin(degtorad(T_Cp_C1_OH)-pi/2)+r_OH_HO];

COOR_CARBOXYL(:,3)=Z+sign*COOR_CARBOXYL(:,3);




end
