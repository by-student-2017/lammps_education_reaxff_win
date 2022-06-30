function Bulk=EdgeOrBulk(ORIGINIAL,EXTENDED,r)
[N,c]=size(ORIGINIAL);
   r=r+0.02; %for making sure that we catch all neighbouring atoms 
   Ind_Neigh = rangesearch(EXTENDED(:,3:5),ORIGINIAL(:,3:5),r);
   
   
   N_Edge=0;
   N_Bulk=0;
   for i=1:N
    A=Ind_Neigh{i};
    [row,N_Neigh]=size(A);
    if (N_Neigh==4)
        N_Bulk=N_Bulk+1;
        Bulk(N_Bulk,:)=ORIGINIAL(i,:);
    else 
        N_Edge=N_Edge+1;
        Edge(N_Edge,:)=ORIGINIAL(i,:);
    end
    
    
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
%    end
% 
    
   
   
   




end
