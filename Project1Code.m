% ME 526 Project 1
% Givens
h=1; %meter
rho=1000; %kg/m3
E=1E9; %Pa
sigmaY=10E6; %Pa
mass=1; %kg

% Design
elements=10; %number of elements
nodes=11; %number of nodes (first and last are for BC)
elementLength=h/elements; %meters; length/elements
areaN=mass/(rho*elementLength); %m^2; Nominal area, uniform beam
kNominal=E*areaN/elementLength; %N/m; desired stiffness of elements
elementCon=readmatrix('ProjectOneUniform.csv'); %read element connectivity file
stiffness=kNominal*ones(10,1); %adding stiffnesses to corresponding elements
forces=0:0.1:1;
forces(1)=-0.5; forces(end)=-0.5; %concatenating the forces at the top & bottom of the beam
forces=9.81*forces'; %N; showing forces experienced at each node

%Calculation
kGlobal=zeros(nodes);
for i=1:elements
    firstCon=elementCon(i,2);
    secondCon=elementCon(i,3);
    ki=stiffness(i);
    kGlobal(firstCon, firstCon)=kGlobal(firstCon, firstCon)+ki;
    kGlobal(firstCon, secondCon)=kGlobal(firstCon, secondCon)-ki;
    kGlobal(secondCon,firstCon)=kGlobal(secondCon,firstCon)-ki;
    kGlobal(secondCon,secondCon)=kGlobal(secondCon,secondCon)+ki;
end

%Applying BC
uGlobal=ones(11,1);
uGlobal(1)=0; uGlobal(11)=0; %Applying Fixed BC
kGlobalR=kGlobal;
% for i=1:nodes
%     for j=1:nodes
%         if 
