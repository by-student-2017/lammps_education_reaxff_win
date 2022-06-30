function Angle_Matrix=Angle(atomdata,Nearest,AngleType)
[N,c]=size(atomdata);
%[N,c]=size(Nearset);
safty=0.01;



%Type: 
%1: C Pristine (Cp)
%2: C Carboxyl (C1)
%3: O in Epoxy Bridge (O)
%4: O the oxygen in the branch with Hydrogen (OH)
%5: H Hydrogen in the branch with Oxygen (HO)
%6: O the oxygen in the branch with no Hydrogen  (O1)

   %1   480.0000     1.3400 # cp-cp  1-1
   %2     384        1.37 # cp-o     1-3
   %3   384.0000     1.3700 # cp-oh  1-4
   %4   351.2527     1.4720 # cp-c1  1-2
   %5   615.3220     1.2300 # c1-o1  2-6
   %6   540.6336     0.9600 # oh-ho  4-5
   %7   400.0000     1.3700 # c1-oh  2-4

% AngleType=zeros(6,6,6);
% AngleType(1,1,1)=1;
% AngleType(1,1,3)=2;
% AngleType(1,1,4)=3;
% AngleType(1,1,2)=4;
% AngleType(1,2,1)=5;
% AngleType(1,2,6)=6;
% AngleType(3,1,3)=7;
% AngleType(1,3,1)=8;
% AngleType(1,4,5)=9;
% AngleType(1,2,4)=10;
% AngleType(4,2,6)=11;
% AngleType(2,4,5)=12;


%Angle . Coeff .   tet0 .       atoms atomtypes .   bondtypes
   %1    90.0000   120.0000 # cp-cp-cp	1-1-1       1-1
   %2    60.0000   120.0000 # cp-cp-o   1-1-3       1-2     
   %3    60.0000   120.0000 # cp-cp-oh  1-1-4       1-3
   %4    34.6799   120.0000 # cp-cp-c1  1-1-2       1-4
   %5    40.0000   115.0000 # cp-c1-cp  1-2-1       4-bar(4)
   %6    54.4949   120.0000 # cp-c1-o1  1-2-6       4-5
   %7    60.0000   120.0000 # o-cp-o    3-1-3       bar(2)-2
   %8    60.0000   109.0000 # cp-o-cp   1-3-1       2-bar(2)
   %9    50.0000   109.0000 # cp-oh-ho  1-4-5       3-6
   %10   54.4949   120.0000 # cp-c1-oh  1-2-4       4-7
   %11   145.0000  123.0000 # oh-c1-o1  4-2-6       bar(7)-5
   %12   50.0000   112.0000 # c1-oh-ho  2-4-5       7-6
   counter=0;
   Atom_ID=atomdata(:,1);
   for i=1:N
       N_Neigh_i=Nearest(i,1);
       A=sort(Nearest(i,2:N_Neigh_i+1));
       iID=find(Atom_ID==atomdata(i,1));
       itype=atomdata(iID,2);
       for j=1:N_Neigh_i
           jID=find(Atom_ID==A(1,j),1);
           jtype=atomdata(jID,2);
           for k=j+1:N_Neigh_i
               kID=find(Atom_ID==A(1,k),1);
               ktype=atomdata(kID,2);
               A_T=AngleType(jtype,itype,ktype);
               if A_T~=0
             counter=counter+1;
             Angle_Matrix(counter,1)=counter;
             Angle_Matrix(counter,2)=A_T;
             Angle_Matrix(counter,3)=Atom_ID(jID,1);
             Angle_Matrix(counter,4)=Atom_ID(iID,1);
             Angle_Matrix(counter,5)=Atom_ID(kID,1);
           end
       end
   end
     clear A  
  
   end
   ID_All=Angle_Matrix(:,3:end);
   Sorted=sort(ID_All,2);
   
   [B,W] = unique(Sorted,'rows','stable');
   D = setdiff(1:size(Sorted,1),W);
   Angle_Matrix(D,:) = [];

   
  [N_Angle,c]=size(Angle_Matrix);
  Angle_Matrix(1:N_Angle,1)=1:N_Angle;
 end
