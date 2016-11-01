%% Traveling salesman problem 
clc;
clear;
close all;
%% Problem Definition

model = CreateModel('1.dat');
CostFunction=@(p) fitness(p, model);
n=model.n;
ActionList=CreatePermActionList(model.n);
nActions=numel(ActionList); 
%% Tabu Search Parameters

MaxIt=10;           % Maximum Number of Iterations
Imdecf=0;mdecf=[];           % Index and list of mouvement which decrease f
t=0.5*nActions;
Tir=zeros(model.n,model.n);           % Initialize The List of Tabu
T=zeros(model.n,model.n);
%% Initialization


PofMi=zeros(1,nActions);
CostofMi=zeros(1,nActions);
DeltaofMi=zeros(1,nActions);
Mdecf=[];

% Create Initial Solution
p1=randperm(model.n);
Cost1=CostFunction(p1);

% Initialize Best Solution Ever Found
BestSol=p1;
% l=[1 0.5*n 0.9*n];
p2=0;
newp=[];
%%
% for l=1:3
    l = 0.5*12;
        for it=1:2000
        %     CostCourant=Cost1;
        
              for i=1:nActions
                  mk=ActionList{i};
                  p2=DoSwap(p1,mk(1,1),mk(1,2));
                  CostofMi(i)=CostFunction(p2);
                  if Tir(i1,r1)<it && Tir(i2,r2)<it
                      DeltaofMi(i)= CostofMi(i) - Cost1;                  
                  else
                      DeltaofMi(i)=500000;
                  end
                  
              end
              BestD=min(DeltaofMi);
              Imdecf = find(DeltaofMi==BestD);
              mdecf = ActionList{Imdecf};
              newp=DoSwap(p1,mdecf(1,1),mdecf(1,2));
              Costofnewp=CostFunction(p1) + BestD;
              t=l+it;
              i1=p1(mdecf(1,1)); r1=mdecf(1,1);
              i2=p1(mdecf(1,2)); r2=mdecf(1,2);
              Tir(i1,r1)=t; Tir(i2,r2)=t;
              if  Tir(i1,r1)<it && Tir(i2,r2)<it
                 	break;
              end
              p1=newp;
        end
% end
% T=Tir;
