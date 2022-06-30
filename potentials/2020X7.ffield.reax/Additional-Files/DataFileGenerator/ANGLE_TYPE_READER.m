function AngleType=ANGLE_TYPE_READER(savedir,filename)

AngleFromTxt = importdata([savedir filename]);
Angle_info=AngleFromTxt.data;
max_size=max(Angle_info(:,1));
AngleType=zeros(max_size,max_size,max_size);
p=1;
for i=1:size(Angle_info,1)
    AngleType(Angle_info(i,1),Angle_info(i,2),Angle_info(i,3))=p;
    if Angle_info(i,1)~=Angle_info(i,3)
        AngleType(Angle_info(i,3),Angle_info(i,2),Angle_info(i,1))=p;
    end
    
    p=p+1;

    
end
end