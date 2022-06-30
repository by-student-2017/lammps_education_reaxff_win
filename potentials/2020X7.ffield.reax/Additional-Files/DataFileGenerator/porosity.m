function XY_Pristine=porosity(PristineAtoms,X_P,Y_P,R_P)
Centre=[X_P,Y_P];
D = pdist2(PristineAtoms(:,1:2),Centre);
XY_Pristine=PristineAtoms(D>R_P,:);
end