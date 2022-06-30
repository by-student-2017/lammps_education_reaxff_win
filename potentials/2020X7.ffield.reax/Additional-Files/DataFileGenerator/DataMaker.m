function DataMaker(savedir, AtomsTotal,FileName,a,BoxSize)
[natoms,col] = size(AtomsTotal);


savedir0= pwd; savedir=[savedir0 '/'];
filenameAT='Atom2.txt';

AtomFromTxt = importdata([savedir filenameAT]);

AtomsTotal0(:,1)=1:natoms;
[elements,indices] = unique(AtomsTotal(:,3));              % get each value with index once

atomtype=size(AtomFromTxt.data,1);

AtomsTotal0(:,2:10)=AtomsTotal(:,2:10);
%[Idx,D] = knnsearch(AtomsTotal0(:,5:7),AtomsTotal0(:,5:7),2);
xy=0; xz=0; yz=0;
%Dumpfile maker
fid = fopen([savedir FileName], 'w');


line=[' ' num2str(natoms) ' atoms'];                                        fprintf(fid,'\n\n%s\n', line);
line=[num2str(atomtype) ' atom types'];                                    fprintf(fid,'%s\n', line);

line=[num2str(BoxSize(1,1)) ' ' num2str(BoxSize(1,2)) ' xlo xhi'];                           fprintf(fid,'%s\n', line);
line=[num2str(BoxSize(2,1)) ' ' num2str(BoxSize(2,2)) ' ylo yhi'];                           fprintf(fid,'%s\n', line);
line=[num2str(BoxSize(3,1)) ' ' num2str(BoxSize(3,2)) ' zlo zhi'];                           fprintf(fid,'%s\n\n', line);
line=['Masses'];                                                           fprintf(fid,'%s\n\n', line);

for i=1:atomtype
    A1=char(AtomFromTxt.textdata(i,1));
    A2=char(num2str(AtomFromTxt.data(i,1),'%.5f'));
    A3=char(AtomFromTxt.textdata(i,2));
    
    line=[A1 '  ' A2 ' # ' A3];
    fprintf(fid,'%s\n', line);
end    


AtomsTotal1=AtomsTotal0(:,[1,3:7]);
AtomsTotal1(:,3)=0;
line='Atoms # charge';                                                       fprintf(fid,'%s\n\n', line);
fprintf(fid,'%d %d %f %f %f  %f\n',AtomsTotal1')
fclose(fid);

        
end
