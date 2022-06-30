function [Epoxy,list]=BondForEpoxy(ORIGINIAL,EXTENDED,r,list,f,double,LP_CP,N_SoFar,H)

%height of oxygen in Epoxy
    h=0.8*LP_CP;
    AVAILABLE=list(:,1);  %list of available atoms
    [Remaining,c]=size(list);
   [N,c]=size(ORIGINIAL);
   N_EPX=floor(f*N);      %Number of epoxy atoms
   N2Choose=N_EPX;
   r=r+0.02; %for making sure that we catch all neighbouring atoms 
   Ind_Neigh = rangesearch(EXTENDED(:,3:5),ORIGINIAL(:,3:5),r);
   k=0;
   while N2Choose>0
        i = AVAILABLE(randi(length(AVAILABLE)),1);  %Choosing a atom randomly from the main list
        A=Ind_Neigh{i};                           %an atom with all the neighbours
        [row,N_Neigh]=size(A);
        j=randperm(N_Neigh-1,1);                   %Choose one of those neighbours randomly
        if (list(i,2)==1 && list(EXTENDED(A(j+1),1),2)==1)
        AVAILABLE(AVAILABLE==i,:)=[];
        list(i,2)=0;
        AVAILABLE(AVAILABLE==EXTENDED(A(j+1),1),:)=[];
        list(EXTENDED(A(j+1),1),2)=0;
        Xi=ORIGINIAL(i,3);   Yi=ORIGINIAL(i,4); Xj=EXTENDED(A(j+1),3);   Yj=EXTENDED(A(j+1),4);       %X and Y of the neighbouring atoms
        X_EP=(Xi+Xj)/2;     Y_EP=(Yi+Yj)/2;                                                 %Corresponding Epoxy position
        if double==1; Z=H+(-1)^(N2Choose)*h; else Z=H+h; end                                       %if both sided so randomly back or front
        k=k+1;
        Epoxy(k,1)=k+N_SoFar; Epoxy(k,2)=9; Epoxy(k,3)=X_EP; Epoxy(k,4)=Y_EP; Epoxy(k,5)=Z; Epoxy(k,6)=i; Epoxy(k,7)=EXTENDED(A(j+1),1);
        N2Choose=N2Choose-1;
        end
    
   end    
    


end
