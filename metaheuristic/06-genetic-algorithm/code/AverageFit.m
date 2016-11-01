%%
clc
clear
close all

%%
tt= [10^3 10^4 10^5];
%tt= [10^5];
ResF = 'Results';% pc = [0 0.6];
% pm = [0.1 0.01];

FName = 'ResAveragefit';
mkdir(ResF,FName);
CurrentF = pwd;
F2SaveRes= strcat(CurrentF,'\',ResF, strcat('\', FName));
fnamefigures = F2SaveRes;
x = 10:1000 ; 
y = 10:1000 ;
[X,Y] = meshgrid(x,y);
z = -abs(0.5.*X.*sin(sqrt(abs(X))))-abs(Y.*sin(30.*sqrt(abs(X./Y))));
optimal_value = min(z(:));
for i=1:size(tt,2)
    
    %pc = 0;   pm = 0.1; 
    %pc = 0;   pm = 0.01; 
    %pc = 0.6;   pm = 0.1; 
    pc = 0.6;   pm = 0.01; 
    nb_exec=25;
    pop_size = 100;
    population = round(rand(pop_size,2)*990)+10;
    g_max = tt(i)/pop_size;
    succ_rate = 0;    
    newfit = 0;
    fitVector = zeros(1,nb_exec);
    pmsptr = strsplit(num2str(pm),'.');pmstr=strcat(pmsptr(1), pmsptr(2));
    
    if pc ==0.6
        pcsptr = strsplit(num2str(pc),'.');pcstr=strcat(pcsptr(1), pcsptr(2));
        workspace = strcat('WS',pcstr,pmstr,num2str(g_max));
    else if pc==0
            workspace = strcat('WS',num2str(pc),pmstr,num2str(g_max));
        end
    end
    %%
    SRATE = succRate(optimal_value, succ_rate, nb_exec,pc,pm,pop_size,g_max, population);
    for i=1:nb_exec
        newfit = main(pc,pm,pop_size,g_max,population);
        fitVector(i) = newfit;
    end
    Meanfitvector = mean(fitVector);
    STDfitvector = std(fitVector);
    %% fig 2, the figure of time execution of each execution and mean and std
    fig2 = figure; hold on;
    plot(1:1:nb_exec, fitVector,'-o',...
               'LineWidth',2,...
               'MarkerEdgeColor','k',...
               'MarkerFaceColor','g',...
               'MarkerSize',5);
           for t=1:2:length(fitVector)
               STDfitvectoname = ['\uparrow', num2str(fitVector(t))];
               text(t,fitVector(t),STDfitvectoname,'VerticalAlignment','cap');
           end
           title(['The Time Execution for ',num2str(nb_exec),' execution'])
           xlabel('Execution number');
           ylabel('Cost');
           grid on;
               % Matrix of Best cost  VS variation of ants number on MaxIt

    param_main =[pc, pm, SRATE, g_max ];
    mata = param_main';
    matrix = vertcat(fitVector',STDfitvector,Meanfitvector,mata) ;
    rowLabels = cell(nb_exec + size(param_main,2),1);
    for s=1:nb_exec + size(param_main,2)
        rowLabels{s} = strcat('run nb : ', num2str(s));
        rowLabels{nb_exec+1} = 'STD';
        rowLabels{nb_exec+2} = 'Mean';
        rowLabels{nb_exec+3} = '$P_c$';
        rowLabels{nb_exec+4} = '$P_{m}$'; 
        rowLabels{nb_exec+5} = '$Succ rate$'; 
        rowLabels{nb_exec+6} = 'generation';
    end
    for u=1
        columnLabels{u} = strcat('fit');
    end

    texfivector= strcat('Averagefit',char(workspace),'.tex');
    matrix2latex(matrix, texfivector, 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny');
    movefile(texfivector,strcat(fnamefigures,'\'));
    save(char(workspace));
    movefile([char(workspace),'.mat'],strcat(fnamefigures,'\'));
end
