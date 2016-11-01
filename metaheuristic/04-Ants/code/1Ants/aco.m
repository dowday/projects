% clc;
% clear;
% close all;

function [solf, bestf, BestCost, cities, model] = aco(filename, nAnt, alpha, beta, rho, MaxIt)
%% Problem Definition
% filename='cities2.dat';
model=CreateModel(filename);
model=model;
cities=model.cities;
CostFunction=@(tour) TourLength(tour,model);

nVar=model.n;

[solu, fsolu] = nn(model.cities); % on prend algo NN comme sol. init.

%% ACO Parameters

% MaxIt=10;      % Maximum Number of Iterations

% nAnt=50;        % Number of Ants (Population Size)

% Q=1;
Q=fsolu;

% tau0=10*Q/(nVar*mean(model.D(:)));	% Initial Phromone

tau0 =(1/fsolu);

% alpha=1;	% Phromone Exponential Weight
% beta=5;     % Heuristic Exponential Weight
% rho=0.1;	% Evaporation Rate


%% Initialization

eta=1./model.D;             % Heuristic Information Matrix

tau=tau0*ones(nVar,nVar);   % Phromone Matrix

BestCost=zeros(1,MaxIt);    % Array to Hold Best Cost Values

% Empty Ant
empty_ant.Tour=[];
empty_ant.Cost=[];

% Ant Colony Matrix
ant=repmat(empty_ant,nAnt,1);

% Best Ant
% BestSol.Cost=inf;
BestSol.Cost=fsolu;
%% ACO Main Loop

for it=1:MaxIt
    
    % Move Ants
    for k=1:nAnt
        
        ant(k).Tour=randi([1 nVar]);
        
        for l=2:nVar
            
            i=ant(k).Tour(end);
            
            P=tau(i,:).^alpha.*eta(i,:).^beta;
            
            P(ant(k).Tour)=0;
            
            P=P/sum(P);
            
            j=RouletteWheelSelection(P);
            
            ant(k).Tour=[ant(k).Tour j];
            
        end
        
        ant(k).Cost=CostFunction(ant(k).Tour);
        
        if ant(k).Cost<BestSol.Cost
            BestSol=ant(k);
        end
        
    end
    
    % Update Phromones
    for k=1:nAnt
        
        tour=ant(k).Tour;
        
        tour=[tour tour(1)]; %#ok
        
        for l=1:nVar
            
            i=tour(l);
            j=tour(l+1);
            
            tau(i,j)=tau(i,j)+Q/ant(k).Cost;
            
        end
        
    end
    
    % Evaporation
    tau=(1-rho)*tau + BestSol.Cost;
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;

    % Show Iteration Information
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
 
    % Plot Solution
%     figure(1);
%     PlotSolution(BestSol.Tour,model);
%     pause(0.01);
    
end
%     figure(1);
%     PlotSolution(BestSol.Tour,model);
%     pause(0.01);
    bestf = BestSol.Cost;
    solf = BestSol.Tour;
%% Results



end