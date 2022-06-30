function Nierest_Neighb=Neib_List(EXTENDED_TOT,atomdata,BOND_LENGTH)
[N,c]=size(atomdata);
[NT,c]=size(EXTENDED_TOT);
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
   counter=0;
   Nierest_Neighb=zeros(N,1);
   for i=1:N
       p_atomi=(atomdata(i,3:5));
       typei=atomdata(i,2);
       p=0;
       for j=1:NT
         typej=EXTENDED_TOT(j,2);
         p_atomj=(EXTENDED_TOT(j,3:5));
         d=norm(p_atomi-p_atomj);
         if (d>eps && d<BOND_LENGTH(typei,typej)+safty)           
             Nierest_Neighb(i,1)=Nierest_Neighb(i,1)+1;
             Nierest_Neighb(i,Nierest_Neighb(i,1)+1)=EXTENDED_TOT(j,1);
         end
       end
   end
             
         
           
   
   
%    r=1.52;
%    Atom1=AtomData(:,4:6);
%    Atom2=AtomData(:,4:6);
%    Ind_Neigh = rangesearch(Atom1,Atom2,r);
%    
%    
%    p=0;
%     for i=1:N
%     A=Ind_Neigh{i};
%     [row,N_Neigh]=size(A);
%     TypeA=AtomData(A(1,1),2);
%         for j=2:N_Neigh
%             TypeB=AtomData(A(1,j),2);
%             if (TypeA==1 & TypeB==1); BondType=1;end; %cp-cp
%             
%             if (TypeA==1 & TypeB==3); BondType=2;end; %cp-o
%             if (TypeA==3 & TypeB==1); BondType=2;end; %o-cp
%             
%             if (TypeA==1 & TypeB==4); BondType=3;end; %cp-oh
%             if (TypeA==4 & TypeB==1); BondType=3;end; %oh-cp
%             
%             if (TypeA==1 & TypeB==2); BondType=4;end; %cp-c1
%             if (TypeA==2 & TypeB==1); BondType=4;end; %c1-cp
%             
%             if (TypeA==2 & TypeB==6); BondType=5;end; %c1-o1
%             if (TypeA==6 & TypeB==2); BondType=5;end; %o1-c1
%             
%             if (TypeA==4 & TypeB==5); BondType=6;end; %oh-ho
%             if (TypeA==5 & TypeB==4); BondType=6;end; %ho-oh
%             
%             if (TypeA==2 & TypeB==4); BondType=7;end; %c1-oh
%             if (TypeA==4 & TypeB==2); BondType=7;end; %oh-c1
%             p=p+1;
%             Bond_Matrix(p,1)=p;
%             Bond_Matrix(p,2)=BondType;
%             Bond_Matrix(p,3)=A(1,1);
%             Bond_Matrix(p,4)=A(1,j);           
%         end
%     clear A
%     end
 end
