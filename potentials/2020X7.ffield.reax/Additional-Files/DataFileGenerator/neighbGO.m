function Tot = neighbGO(cut, Xlo, Xhi, Ylo, Yhi, Zlo, Zhi, atom)
rowcolsize=size(atom);
natom=rowcolsize(1,1);
lX=Xhi-Xlo;
lY=Yhi-Ylo;
lZ=Zhi-Zlo;
p=1;
nextend=26*natom;
extend=zeros(nextend,rowcolsize(1,2));
for i=1:natom
    %one of x or y or z are----------------------------- 
    if (Xhi-atom(i,3)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5);
        p=p+1;
    elseif (atom(i,3)-Xlo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5);
        p=p+1;
    end
    if (Yhi-atom(i,4)<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5);
        p=p+1;
    elseif (atom(i,4)-Ylo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5);
        p=p+1;
    end
    if (Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    elseif (atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
        %two of x or y or z are 
    if (Xhi-atom(i,3)<=cut && Yhi-atom(i,4)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5);
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && Yhi-atom(i,4)<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5);
        p=p+1;
    end
    if (Xhi-atom(i,3)<=cut && atom(i,4)-Ylo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5);
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && atom(i,4)-Ylo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5);
        p=p+1;
    end
    if (Xhi-atom(i,3)<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (Xhi-atom(i,3)<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4);
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (Yhi-atom(i,4)<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (atom(i,4)-Ylo<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (Yhi-atom(i,4)<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (atom(i,4)-Ylo<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1);
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3);
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    %three of x or y or z are 
    if (Xhi-atom(i,3)<=cut && Yhi-atom(i,4)<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (Xhi-atom(i,3)<=cut && Yhi-atom(i,4)<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (Xhi-atom(i,3)<=cut && atom(i,4)-Ylo<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (Xhi-atom(i,3)<=cut && atom(i,4)-Ylo<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)-lX;
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && Yhi-atom(i,4)<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && Yhi-atom(i,4)<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4)-lY;
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && atom(i,4)-Ylo<=cut && atom(i,5)-Zlo<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5)+lZ;
        p=p+1;
    end
    if (atom(i,3)-Xlo<=cut && atom(i,4)-Ylo<=cut && Zhi-atom(i,5)<=cut)
        extend(p,1)=atom(i,1); 
        extend(p,2)=atom(i,2);
        extend(p,3)=atom(i,3)+lX;
        extend(p,4)=atom(i,4)+lY;
        extend(p,5)=atom(i,5)-lZ;
        p=p+1;
    end
    
    
end
Tot=zeros(natom+p-1,rowcolsize(1,2));
for i=1:natom
    Tot(i,:)=atom(i,:);
end
for i=1:p-1
    Tot(i+natom,:)=extend(i,:);
end
    
end


