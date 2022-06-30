function PristineAtoms=expand(a_0_CP,Basis_CP,N_ucX,N_ucY,H,type)
[NBasis,c]=size(Basis_CP);
LowX=0; HighX=N_ucX-1;  
LowY=0; HighY=N_ucY-1;  
LowZ=H; HighZ=H;


for i=1:NBasis
Xvec(i,:)=LowX:1:HighX;
Xvec(i,:)=Xvec(i,:)+Basis_CP(i,1);
Yvec(i,:)=LowY:1:HighY;
Yvec(i,:)=Yvec(i,:)+Basis_CP(i,2);
Zvec(i,:)=LowZ:1:HighZ;
Zvec(i,:)=Zvec(i,:)+Basis_CP(i,3);
PristineAtoms0(i,:,:)=combvec(Xvec(i,:),Yvec(i,:),Zvec(i,:))';
end

[Q,QQ,QQQ]=size(PristineAtoms0);
p=0;
q=QQ;
for i=1:NBasis
  PristineAtoms(p+1:q,1:3)= PristineAtoms0(i,:,:);
  p=q;
  q=(i+1)*QQ;
end


PristineAtoms(:,1)=PristineAtoms(:,1).*a_0_CP(1,1);
PristineAtoms(:,2)=PristineAtoms(:,2).*a_0_CP(1,2);
PristineAtoms(:,3)=PristineAtoms(:,3);
%PristineAtoms(:,3)=PristineAtoms(:,3).*a_0_CP(1,3);
end