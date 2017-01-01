
clc;
clear;
close all;

%% Parameters
filename='cities.dat';
fnamefigures = 'C:\Users\mod\OneDrive\2015-2016\Uni\AutumnSem2015\1 - MHOA\MHOA\TP\TP4_MHOA\MHOA_tex_Cours\figures\exp_alph_0_beta_5_new';
alpha =1; % 0, 1, 5
beta = 5; % 0, 1, 5
rho = 0.1;
nb_exec = 5;
MaxIt=10; % 10, 20, 40, 50
nAnts = [20 40 60 80 100]; lnAnts = length(nAnts);
legendInfo=zeros(0,1);
% MaxIt = [10 20 40 60 80]; lnnMaxIt = length(MaxIt);

%% Intialisation matrix results
AS_BestCost_for_nb_exec =  zeros(nb_exec, MaxIt);

% Execution time with Ants variation, Mean and STD  
AS_Exec_Time_Varying_nAnts=zeros(0,1); % Execution time with ants variation

%% Run the algorithm 
for exec=1:nb_exec
tic
[AS_SeqSolBestf, AS_Bestf, AS_BestCost, cities, model] = aco(filename, nAnts(exec), alpha, beta, rho, MaxIt);
AS_Exec_Time_Varying_nAnts(exec) = toc;
AS_BestCost_for_nb_exec(exec,:) = AS_BestCost;
AS_BestCost(nb_exec) = AS_BestCost(1,end);
end
AS_Mean_for_Time_Exec = mean(AS_Exec_Time_Varying_nAnts);
AS_STD_for_Time_Exec = std(AS_Exec_Time_Varying_nAnts);
AS_Mean_BestCost_for_nb_exec = mean(AS_Exec_Time_Varying_nAnts);
AS_STD_BestCost_for_nb_exec = std(AS_BestCost);

%% plot figures
fig1 = figure;hold on
for exec=1:nb_exec
    legendInfo{exec} = [ num2str(nAnts(exec)) ' ants'];
    
    plot(1:1:MaxIt,AS_BestCost_for_nb_exec(exec,:),'-o',...
                       'LineWidth',1.5,...
                       'MarkerFaceColor','g',...
                       'MarkerSize',5);
    title(sprintf('Best cost  VS variation of ants number on %d', MaxtIt))

    legend(legendInfo)
    xlabel('Iteration');
    ylabel('Best cost');
    grid on;
end
for j=1:(size(AS_BestCost_for_nb_exec,1)-1):size(AS_BestCost_for_nb_exec,1)
    for i=1:size(AS_BestCost_for_nb_exec,2)
        BestCost = [' \leftarrow', num2str(AS_BestCost_for_nb_exec(i))];
        text(i,AS_BestCost_for_nb_exec(j,i),BestCost,'Rotation',50);
    end
end
print(fullfile(fnamefigures,'AS_BestCost_for_nb_exec'),'-depsc')
print(fullfile(fnamefigures,'AS_BestCost_for_nb_exec'),'-djpeg')
savefig(fig1,fullfile(fnamefigures,'AS_BestCost_for_nb_exec.fig'),'compact')
% fig 2 
fig2 = figure; hold on;
plot(1:1:nb_exec, AS_Exec_Time_Varying_nAnts,'-o',...
                       'LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',5);
for i=1:length(AS_Exec_Time_Varying_nAnts)
    std_time_exec = ['  \leftarrow', num2str(AS_Exec_Time_Varying_nAnts(i))];
    text(i,AS_Exec_Time_Varying_nAnts(i),std_time_exec,'HorizontalAlignment','left');
end
stepz(AS_Mean_for_Time_Exec);hold on
Mean_time_exec = [' \leftarrow Mean time execution = ', num2str(AS_Mean_for_Time_Exec)];
text(0,AS_Mean_for_Time_Exec,Mean_time_exec,'Rotation',40);
stepz(AS_STD_for_Time_Exec); hold on
std_time_exec = ['  \leftarrow STD of time execution = ', num2str(AS_STD_for_Time_Exec)];
text(0,AS_STD_for_Time_Exec,std_time_exec,'Rotation',40);
title(sprintf('Execution time on %d execution',nb_exec))
xlabel('Execution number');
ylabel('Time');
grid on;

%% Save figures
print(fullfile(fnamefigures,'AS_1_5_BestCost_Varying_Iteration_and_nbAnts'),'-depsc')
print(fullfile(fnamefigures,'AS_1_5_BestCost_Varying_Iteration_and_nbAnts'),'-djpeg')
savefig(fig2,fullfile(fnamefigures,'AS_1_5_BestCost_Varying_Iteration_and_nbAnts.fig'),'compact')

%% Produce latex table
% Matrix of Best cost  VS variation of ants number on MaxIt
matrix = AS_BestCost_for_nb_exec;
rowLabels = {'exec 2', 'exec 2','exec 3','exec 4','exec 5'}; 
columnLabels = {'It 1', 'It 2','It 3','It 4j','It 5','It 6','It 7','It  1','row 1','row 1'}; 
fopen('out.tex');
matrix2latex(matrix, 'out.tex', 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny'); 

% Matrix of STD, Mean and Exec time
% matrix = AS_Exec_Time_Varying_nAnts';
% matrix = vertcat(matrix, AS_Mean_for_Time_Exec, AS_STD_for_Time_Exec);
% rowLabels = {'exec 1', 'exec 2','exec 3','exec 4','exec 5','Mean','STD'}; 
% columnLabels = {'Elapsed time'}; 
% fopen('ExeTimeMeanSTD1.tex');
% matrix2latex(matrix, 'ExeTimeMeanSTD1.tex', 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny'); 

%  figure;
%  PlotSolution(AS_SeqSolBestf,model); title('Path')