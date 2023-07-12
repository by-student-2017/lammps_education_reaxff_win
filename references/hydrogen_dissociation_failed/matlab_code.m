%-------------------------------------------------------------------
%COUNTING MOLECULES USING THE TRAJECOTRY FILES FROM THE REAXFF 
%SIMULATIONS
%-------------------------------------------------------------------
%-------------------------------------------------------------------
% This code counts the number of molecules in a system with
% periodic boundary conditions using trajectory files. Additional
% trajectory %files are created; one for the atoms and one for
% the molecules.
%
%generated by Nora Meling Eriksen and Thuat Trinh on 2015/05/12 
%11:51:42
%-------------------------------------------------------------------
clear all; close all; clc

%start after equilibrium is reached, which is after a 1000 frames
%frame = the positions of a thousand atoms at a given time step
teller1 = 3+1002*1000;. Start at frame 1000
teller2 = 1002+1002*1000; % End of frame 1000

t = -500; 
boxsize = 68.469;
filnavn ='T12998.xyz'; % the data file
run = 50; %number of frames


d_max = 1.8;% Å Max length between two atoms in a molecules


for k = 1:run %Defines the number of frames we want
	[data(:,1), data(:,2), data(:,3)] = importfile(filnavn,teller1,teller2);%Imports inn one frame at a given time step. Importfile was created by a built-in function in MATLAB 
	
	molekyl = 0;
	atom = 0;
	h2atom = [];
	H2atom = [];
	H = [];
	H2molecule = [];
	
	%One position in the trajectory file is compared with all the 
	%following positions
	for i = 1:size(data,1) 
		a = data(i,:); %current position
		z = i+1;
		for p = z:size(data,1) 
			b = data(p,:);%the current following position
			if b == a %if the positions are equal, break 
				break
			end
			d=sqrt(sum((a-b).^2));%calculates the distance
			if d > boxsize/2 %check PBC for shortest distance
				d2=boxsize;
				for kx=-1:1
					for ky=-1:1
						for kz=-1:1
							b=b+[kx,ky,kz]*boxsize;
							d2=sqrt(sum((a-b).^2));
							d=min(d2,d); 
						end
					end
				end
			end
			
			if d <= d_max %if the distance between the two points are lower or equal to one
				H2atom = [H2atom; data(i,:); data(p,:)]; %collect the positions to all the atoms that makes molecules
				H2molecule = [H2molecule; data(i,:)]; %collects the positions to only one of the two atoms in a molecule
				molekyl = molekyl + 1; %counts a molecule
				break
				
				%if the distance is too large, we have to check if the atom is found at the boundary of the box since we have periodic boundary conditions
				
			end
		end
	end
	
	COM =[d_max/2 d_max/2 d_max/2]; %center of mass
	Batom = bsxfun(@minus,H2molecule,COM); %Creates a new atom B from the H2 molecules

	%Must create a vector for Hatoms. Compare data with H2atoms
	H = data;
	for i = 1:size(H2atom,1)
		a = bsxfun(@eq,data,H2atom(i,:));%finds where the coordinates are equal
		z = sum(a,2); %sums up the matrix, if the coordinates are equal the sum is 3
		b = find(z==3);
		if b > 0
			H(b,:)=[0 0 0]; %removes the positons where a molecules atom is placed
		end
	end
	
	Hatom = [];
	c = find(H(:,1)>0);
	for j = 1:size(c) %removes the zeros
		Hatom = [Hatom; H(c(j),:)];
	end
	t = t + 500; %increases the time step
	h2atom=unique(h2atom);
	molekyl=size(h2atom)/2;
	
	Mol(k) = molekyl(1,1); %stores the number of molecules for each frame in a vector which is the length of the number of frames. 
	Atm(k) = 1000-2*molekyl(1,1); %stores the number of atoms for each frame in a vector which is the length of the number of frames. 
	teller1 = teller1 + 1002; teller2 = teller2 + 1002; %moves on to next frame
	Time(k) = t; %creates a vector for the time steps 
k
end

%-------------------------------------------------------------------
%SCRIPT AND FUNCTIONS TO CALCULATE THE THERMODYNAMIC CORRECTION 
%FACTOR USING THE REAXFF TRAJEECTORIES
%-------------------------------------------------------------------
%-------------------------------------------------------------------
%THE SCRIPT 
% This script calculates the thermodynamic correction factor for
% a mixture of H and H2 using the Small System Method and plots 
% them. In this script is all the initial values defined which is 
% used in the function TDF_Nora. The output of the function is 
% plotted.
%
%generated by Nora Meling Eriksen on 2015/05/12 11:51:42
%-------------------------------------------------------------------
clear all; close all; clc
 
%The file we are calculating from
filnavn ='T3639.xyz'; %Imports the data file

%Initial values for the counting code
boxsize = 68.48;
d_max = 1.8; % Maximum distance between two atoms in a molecule
rmin = 0.05; % Smallest radius in the small system spheres
rmax = 0.4790; % Largest radius in the small system spheres
numVolumes = 200;% Number of small system spheres
numRadii= 30; % Number of radii
run = 50; % Number of time steps
covHB = [];

%Perform SSM in each atom vector
data= TDF_Nora(rmin,rmax,numVolumes,numRadii,run,filnavn,boxsize,d_max);
R =(data.radius);
L =((((4/3)*pi).*R.^3).^(1/3).*boxsize); %scaling L to the correct boxsize
L_1 =fliplr((L.').^-1); %makes sure the largest box size is first
sphH =(data.spheresH);
gammaH = var(sphH,1)./mean(sphH); % 1/Gamma
sphB =(data.spheresB);
gammaB = var(sphB,1)./mean(sphB); % 1/Gamma
for g = 1:30
	C = cov(sphB(:,g),sphH(:,g));
	covHB = [covHB; C(1,2)];
end
gammaHB = (covHB.')./mean(sphH); %1/Gamma

figure
plot(L_1,gammaH,'-*',L_1,gammaB,'-o',L_1,gammaHB,'-^')
xlabel('1/L [Å^-^1]');
ylabel('\Gamma^{-1}');
legend('H-H','H_2-H_2','H-H_2','location','best')
box off
legend('boxoff') 
save('gammaT3936.mat','gammaH','gammaB','gammaHB')

%-------------------------------------------------------------------
%THE SMALL SYSTEM METHOD FUNCTION
% This code creates two new trajectories for H and H2 in a
% mixture of H2 and H. The Small System Method is used to
% calculate the thermodynamic correction on each trajectory.
% This code imports the initial variables set in the script
%
%generaded by Bjørn Strøm, Nora Meling Eriksen and Thuat Trinh
%on 2015/05/12 11:51:42
%-------------------------------------------------------------------
function [varargout] = 
TDF_Nora(rmin,rmax,numVolumes,numRadii,run,filnavn,boxsize,d_max)

RangeY = 1;

%% Initialize variables 
radius =[rmin:0.0042:0.114 0.115:0.028:rmax];
spheresH = zeros(numVolumes*10000,numRadii);
sphere_countsH = zeros(numVolumes,numRadii);
spheresB = zeros(numVolumes*10000,numRadii);
sphere_countsB = zeros(numVolumes,numRadii);
%% Counting code 
teller1 = 3+1002*1000;
teller2 = 1002+1002*1000;

for k = 1:run 
	[data(:,1), data(:,2), data(:,3)] = importfile(filnavn,teller1,teller2);
	atom = 0;
	h2atom = [];
	H2atom = [];
	H = [];
	H2molecule = [];
	
	for i = 1:size(data,1) 
		a = data(i,:); 
		z = i+1;
		for p = z:size(data,1) 
			b = data(p,:);
			if b == a 
				break
			end
			d=sqrt(sum((a-b).^2));
			
			if d > boxsize/2 
				d2=boxsize;
				for kx=-1:1
					for ky=-1:1
						for kz=-1:1
							b=b+[kx,ky,kz]*boxsize;
							d2=sqrt(sum((a-b).^2));
							d=min(d2,d); 
						end
					end
				end
			end
			
			if d <= d_max 
				H2atom = [H2atom; data(i,:); data(p,:)]; 
				H2molecule = [H2molecule; data(i,:)]; 
				break
			end
		end
	end
	
	COM =[d_max/2 d_max/2 d_max/2];
	Batom = bsxfun(@minus,H2molecule,COM);
	H = data;
	for i = 1:size(H2atom,1)
		a = bsxfun(@eq,data,H2atom(i,:));
		z = sum(a,2); 
		b = find(z==3);
		if b > 0
			H(b,:)=[0 0 0]; 
			end
		end
		
		Hatom = [];
		c = find(H(:,1)>0);
		for j = 1:size(c) 
			Hatom = [Hatom; H(c(j),:)];
		end
		
		atomCoordinatesH = Hatom./boxsize;
		atomCoordinatesB = Batom./boxsize;
		
		for l = 1:numVolumes
			[sphere_countsH(l,:)] = PBC_Nora(radius,atomCoordinatesH);
			[sphere_countsB(l,:)] = PBC_Nora(radius,atomCoordinatesB);
		end
		
		spheresH(1+(k-1)*numVolumes:k*numVolumes,:) = sphere_countsH; 
		spheresB(1+(k-1)*numVolumes:k*numVolumes,:) = sphere_countsB;
		
		teller1 = teller1 + 1002;
		teller2 = teller2 + 1002; 
	k
	end 
	
	spheresH(k*numVolumes+1:end,:) = [];
	spheresB(k*numVolumes+1:end,:) = [];
	%OUTPUTS IN SAME VARIABLE STRUCTURE
	varargout{1}.spheresH = fliplr(spheresH);
	varargout{1}.spheresB = fliplr(spheresB);
	varargout{1}.radius = radius;
	varargout{1}.RangeY = RangeY;
end

%-------------------------------------------------------------------
%PBC_NORA takes in a (1 x a) vector of radii, and an (m x n) matrix 
% of atom coordinates. The output is a (1 x a) vector where each
% element is the number of atoms located within a spherical 
% selection with the corresponding radius given by the provided
% input vector. The selections are random, for each time the 
% function is called, but have the same center for each radius 
% within the same call. This is done for computational efficiency
% because it allows us to shrink the selection from largest to 
% smallest radius.
% 
% m = no. of atoms 
% n = 3 (x, y, z) The coordinates are scaled between 0 and 1 to 
% represent a fraction of the simulation box size.
% 
% generated by Bjørn Strøm on 2015/05/12 11:51:42
%-------------------------------------------------------------------

function [sphere_count] = PBC_Nora(radius,atom_coordinates)

num_radii = length(radius); 
radius = fliplr(radius); % the radius vector is reversed to allow.. 
sphere_c = rand(1,3); % ..the selections to shrink in size
box_c = [0.5,0.5,0.5]; % simulation box center position
trans_vec = box_c - sphere_c; % translation vector for PBC
sphere_list = bsxfun(@plus,atomCoordinates,trans_vec); % Translates… 
sphere_count = zeros(numRadii,1); % … atom Coordinates with trans_vec.

%% Wrap the spherical selection for periodic boundary conditions
if trans_vec(1) > 0 
	x_check = bsxfun(@gt,sphere_list(:,1),1); 
	sphere_list(:,1) = sphere_list(:,1) - x_check; 
else
	x_check = bsxfun(@lt,sphere_list(:,1),0); 
	sphere_list(:,1) = sphere_list(:,1) + x_check; 
end

if trans_vec(2) > 0 
	y_check = bsxfun(@gt,sphere_list(:,2),1);
	sphere_list(:,2) = sphere_list(:,2) - y_check;
else
	y_check = bsxfun(@lt,sphere_list(:,2),0);
	sphere_list(:,2) = sphere_list(:,2) + y_check;
end

if trans_vec(3) > 0 
	z_check = bsxfun(@gt,sphere_list(:,3),1);
	sphere_list(:,3) = sphere_list(:,3) - z_check;
else
	z_check = bsxfun(@lt,sphere_list(:,3),0);
	sphere_list(:,3) = sphere_list(:,3) + z_check;
end

% Make a spherical selection for each radius
for i = 1:numRadii 
	sphere_select = ((sphere_list(:,1) - box_c(1)).^2 + (sphere_list(:,2) - box_c(2)).^2 + (sphere_list(:,3) - box_c(3)).^2 ) <= radius(i)^2; 
	sphere_count(i) = sum(sphere_select); 
	sphere_list = reshape(sphere_list(repmat(sphere_select,[1,3])), [sphere_count(i),3]); 
end

end
