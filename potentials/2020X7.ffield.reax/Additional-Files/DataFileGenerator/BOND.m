function Bond_Matrix=BOND(EXTENDED_TOT,atomdata,BOND_LENGTH,Bond_Type)
[N,c]=size(atomdata);
[NT,c]=size(EXTENDED_TOT);
safty=0.01;

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
%13: H in Carboxyl (HCE
%14: H in Hydroxyl (HH)
%15: H in Water (HW)
%16: H in deuterated water (HD)
%17: C Pristine edge (CpE)


   %1   469.0000     1.4    # CpB-CpB  1-1
   %2   469.0000     1.4    # CpB-CC1  1-2
   %3   469.0000     1.4    # CpB-CE   1-4
   %4   469.0000     1.4    # CpB-CH   1-5
   %5   469.0000     1.4    # CpB-CpE  1-17
   %6   469.0000     1.4    # CC1-CC1  2-2
   %7   351.2527     1.4720 # CC1-CC2  2-3
   %8   469.0000     1.4    # CC1-CE   2-4
   %9   469.0000     1.4    # CC1-CH   2-5
   %10  469.0000     1.4    # CC1-CpE  2-17
   %11  615.3220     1.23   # CC2-OC1  3-7
   %12  400.0000     1.37   # CC2-OC2  3-8
   %13  469.0000     1.4    # CE-CE    4-4
   %14  469.0000     1.4    # CE-CH    4-5
   %15  320.0000     1.41   # CE-OE    4-9
   %16  469.0000     1.4    # CE-CpE   4-17
   %17  469.0000     1.4    # CH-CH    5-5
   %18  450.0000     1.364  # CH-OH    5-10
   %19  469.0000     1.4    # CH-CpE   5-17
   %20  469.0000     1.4    # CW-CW    6-6
   %21  540.6336     0.96   # OC2-HC   8-13
   %22  540.6336     0.96   # OH-HH    10-14
   %23  469.0000     1.4    # CpE-CpE  17-17


   counter=0;
   for i=1:N
       p_atomi=(atomdata(i,3:5));
       typei=atomdata(i,2);
       for j=i+1:NT
         typej=EXTENDED_TOT(j,2);
         p_atomj=(EXTENDED_TOT(j,3:5));
         d=norm(p_atomi-p_atomj);
         if (d<BOND_LENGTH(typei,typej)+safty & d>BOND_LENGTH(typei,typej)-safty)

         %if (d<BOND_LENGTH(typei,typej)+safty & atomdata(i,1)<EXTENDED_TOT(j,1) & d>BOND_LENGTH(typei,typej)-safty)
             counter=counter+1;
             Bond_Matrix(counter,1)=counter;
             Bond_Matrix(counter,2)=Bond_Type(typei,typej);
             Bond_Matrix(counter,3)= atomdata(i,1);
             Bond_Matrix(counter,4)= EXTENDED_TOT(j,1);
             
         end
       end
   end
   
   ID_All=Bond_Matrix(:,3:end);
   Sorted=sort(ID_All,2);
   
   [B,W] = unique(Sorted,'rows','stable');
   D = setdiff(1:size(Sorted,1),W);
   Bond_Matrix(D,:) = [];

   
  [N_Bond,c]=size(Bond_Matrix);
  Bond_Matrix(1:N_Bond,1)=1:N_Bond;
  
  
  
  
             
         
           

 end
