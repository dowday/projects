
clc;
clear;
close all;

%% Problem Definition
% filename = 'cities.dat';
filename = 'cities2.dat';
T0 = Temp(filename);
% T0 = Temp(filename);
model=CreateModel(filename);    % Create Problem Model

CostFunction=@(tour) TourLength(tour,model);    % Cost Function

%% SA Parameters

MaxIt=200;      % Maximum Number of Iterations

MaxSubIt=200;    % Maximum Number of Sub-iterations

%%
% T0=2.4; %     % Initial Temp.
% T0=0.014;  %
% % T0 = TempIni();
%%
alpha=0.99;     % Temp. Reduction Rate

%% Initialization

% Create and Evaluate Initial Solution
sol.Position=CreateRandomSolution(model);
sol.Cost=CostFunction(sol.Position);

% Initialize Best Solution Ever Found
BestSol=sol;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Intialize Temp.
T=T0;
tic


%% SA Main Loop

for it=1:MaxIt
    
    for subit=1:MaxSubIt
        
        % Create and Evaluate New Solution
        newsol.Position=CreateNeighbor(sol.Position);
        newsol.Cost=CostFunction(newsol.Position);
        
        if newsol.Cost<=sol.Cost % If NEWSOL is better than SOL
            sol=newsol;
            
        else % If NEWSOL is NOT better than SOL
            
            DELTA=(newsol.Cost-sol.Cost)/sol.Cost;
            
            P=exp(-DELTA/T);
            if rand<=P
                sol=newsol;
            end
            
        end
        
        % Update Best Solution Ever Found
        if sol.Cost<=BestSol.Cost
            BestSol=sol;
        end
    
    end
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Update Temp.
    T=alpha*T;
    
   % Plot Best Solution
    figure(1);
    PlotSolution(BestSol,model);
    pause(0.01);
    
end

%% Results
m = mean(BestCost); disp(m)
std = std(BestCost) ; disp(std)
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
toc