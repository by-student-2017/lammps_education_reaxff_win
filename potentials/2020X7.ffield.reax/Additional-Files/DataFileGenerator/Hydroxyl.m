function [TYPE_H,COOR_HYDROXYL]=Hydroxyl(X,Y,Z,r_HYDROXYL,Teta_HYDROXYL,sign)

%4: O the oxygen attached to Hydrogen (OH)
%5: H Hydrogen attached to Oxygen (HO)

% if double==1
% sign=(-1)^(randi([1,2],1,1));
% else
%    sign=1;
% end

%Bonds in Hydroxyl
r_Cp_OH=r_HYDROXYL(1,1);
r_OH_HO=r_HYDROXYL(1,2);
 

%OH
TYPE_H(1,1)=10;
COOR_HYDROXYL(1,1:3)=[X,Y,r_Cp_OH];

%OH
TYPE_H(1,2)=14;
COOR_HYDROXYL(2,1:3)=[X-r_OH_HO*cos(degtorad(Teta_HYDROXYL)-pi/2),Y,r_Cp_OH+r_OH_HO*sin(degtorad(Teta_HYDROXYL)-pi/2)];

COOR_HYDROXYL(:,3)=Z+sign*COOR_HYDROXYL(:,3);
end
