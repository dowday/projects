%%
clc;
clear;
close all;

%%
Files2Test = {'cities.dat'};
%Files2Test = {'cities.dat', 'cities2.dat', 'rnd50.dat', 'rnd60.dat', 'rnd80.dat', 'rnd100.dat'};
SofF2test = size(Files2Test);
nbAnts= 40;
ResF = 'AllResofExpSA';
nb_exec = 2 ;
for i=1:SofF2test(2)
    filename=Files2Test{i};
    figtitnamec = filename; 
    spltfilename = strsplit(filename,'.');
    FName = ['ResultOf',spltfilename{1}];
    mkdir(ResF,FName);
    CurrentF = pwd;
    F2SaveRes= [CurrentF,'\',ResF,'\', FName];
    fnamefigures = F2SaveRes;
    Nofworkspace = F2SaveRes;
    fig2= figure;
    %% run the algo
    for exec=1:nb_exec
        tic
        sa;    
        AS_Exec_Time_Varying_nAnts(exec) = toc;
        AS_BestCost_for_nb_exec(exec,:) = BestCost;
        %     AS_BestCost(nb_exec) = AS_BestCost(1,end);
        AS_BestCost(nb_exec) = min(BestCost);
    end
    AS_Mean_for_Time_Exec = mean(AS_Exec_Time_Varying_nAnts);
    AS_STD_for_Time_Exec = std(AS_Exec_Time_Varying_nAnts);
    AS_Mean_BestCost_for_nb_exec = mean(AS_Exec_Time_Varying_nAnts);
    AS_STD_BestCost_for_nb_exec = std(AS_BestCost);
    %%
    fignamea = ['path'];
    print(fullfile(fnamefigures,fignamea),'-depsc')
    print(fullfile(fnamefigures,fignamea),'-djpeg') 
    fignametosave = [fignamea,'.fig'];
    savefig(fig2,fullfile(fnamefigures,'path'),'compact')
    save(Nofworkspace)
    movefile([Nofworkspace,'.mat'],[fnamefigures,'\'])
    
        %% fig 2, the figure of time execution of each execution and mean and std
    fig2 = figure; hold on;
    plot(1:1:nb_exec, AS_Exec_Time_Varying_nAnts,'-o',...
                           'LineWidth',2,...
                           'MarkerEdgeColor','k',...
                           'MarkerFaceColor','g',...
                           'MarkerSize',5);
    for t=1:length(AS_Exec_Time_Varying_nAnts)
        std_time_exec = ['\uparrow', num2str(AS_Exec_Time_Varying_nAnts(t))];
        text(t,AS_Exec_Time_Varying_nAnts(t),std_time_exec,'VerticalAlignment','cap');
    end
    stepz(AS_Mean_for_Time_Exec);hold on
    Mean_time_exec = [' \leftarrow Mean time execution = ', num2str(AS_Mean_for_Time_Exec)];
    text(0,AS_Mean_for_Time_Exec,Mean_time_exec,'Rotation',0);
    stepz(AS_STD_for_Time_Exec); hold on
    std_time_exec = ['  \leftarrow STD of time execution = ', num2str(AS_STD_for_Time_Exec)];
    text(0,AS_STD_for_Time_Exec,std_time_exec,'Rotation',0);
    title([figtitnamec,', ','The Time Execution for ',num2str(nb_exec),' execution'])
    xlabel('Execution number');
    ylabel('Time');
    grid on;
    
        % Save figures
    figname = ['ExecTimeAndMeanSTDWith'];
    print(fullfile(fnamefigures,figname),'-depsc')
    print(fullfile(fnamefigures,figname),'-djpeg') 
    fignametosave = [figname,'.fig'];
    savefig(fig2,fullfile(fnamefigures,fignametosave),'compact') 
    save([pwd,['\',filename,'AllResofExpSA']])
    
    figItBestCost= figure;
    plot(BestCost,'LineWidth',2);
    xlabel('Iteration');
    ylabel('Best Cost');
    TBestCost=BestCost';
    grid on;
    for k=10:10:size(TBestCost,2)
        for j=1:20:100
            BestCostname = [' \leftarrow ', num2str(TBestCost(1,j))];
            text(j,TBestCost(1,j),BestCostname,'Rotation',20);
        end
    end
    fignameibc = ['VARitVSbestcost'];
    print(fullfile(fnamefigures,fignameibc),'-depsc')
    print(fullfile(fnamefigures,fignameibc),'-djpeg') 
    fignametosave = [fignameibc,'.fig'];
    savefig(figItBestCost,fullfile(fnamefigures,fignametosave),'compact') 
        % Matrix of Best cost  VS variation of ants number on MaxIt
    matrix = AS_BestCost_for_nb_exec;
    rowLabels= cell(1,nb_exec);
    for s=1:nb_exec
        rowLabels{s} = strcat('exec : ', num2str(s));
    end
    for u=1:MaxIt
        columnLabels{u} = strcat('It : ', num2str(u));
    end

    texAS_BestCostfile=  strcat(spltfilename{1},'_','AS_BestCost_for_nb_exec.tex');
    matrix2latex(matrix, texAS_BestCostfile, 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny'); 
    movefile(texAS_BestCostfile,strcat(fnamefigures,'\'))
    
    %{ STD and Mean %}
    matrix = AS_Exec_Time_Varying_nAnts';
    matrix2 = vertcat(matrix, AS_Mean_for_Time_Exec, AS_STD_for_Time_Exec);
    for r=1:(nb_exec)
        rowLabels{r} = strcat('exec : ', num2str(r));
    end
    rowLabels{size(matrix2,1)-1}=' Mean';
    rowLabels{size(matrix2,1)}=' STD';
% %     rowLabels = {'exec 1', 'exec 2','exec 3','exec 4','exec 5','Mean','STD'}; 
    columnLabels = {'Elapsed time'}; 
% % % %     a= fopen('ExeTimeMeanSTD2.tex');
    texSTDfile=  strcat(spltfilename{1},'_','ExeTimeMeanSTD.tex');
    matrix2latex(matrix2,texSTDfile, 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny'); 
    movefile(texSTDfile,strcat(fnamefigures,'\'))
end