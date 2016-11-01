
clc;
clear;
close all;

%% notion
	% f~ folder
	% Res = result 
%% Defining all the parameters 
    % fnamefigures = 'C:\Users\mod\OneDrive\2015-2016\Uni\AutumnSem2015\1 - MHOA\MHOA\TP\TP4_MHOA\code\All_Resof_Exps\Result_of_rnd_50';
    Files2Test = {'cities.dat', 'cities2.dat', 'rnd50.dat', 'rnd60.dat', 'rnd80.dat', 'rnd100.dat'};SofF2test = size(Files2Test);
    % Files2Test = {'cities.dat', 'cities2.dat', 'rnd50.dat', 'rnd60.dat', 'rnd80.dat', 'rnd100.dat'};SofF2test = size(Files2Test);
    %Files2Test = {'cities.dat'};SofF2test = size(Files2Test);
    prompt = 'If you want exp with variation n put 1, if you want to fix nbants=40 put 2 value : ';
    exper = input(prompt);
    if exper==1
        prompt1 = 'IF your choise is 1 then input the number of execution you want 5 or 10 else if its 2  the number of exec is fixed on 10 : ';
        exper1 = input(prompt1);
    elseif exper==2
    end
    alpha =1; % 0, 1, 5
    beta = 5; % 0, 1, 5
    rho = 0.1;
    nb_exec = 10;
    MaxIt=10; % 10, 20, 40, 50
    if exper == 1 && exper1 == 5
        nAnts = [20 40 60 80 100]; lnAnts = length(nAnts);
        ResF = 'AllResofExpfiveA';
    elseif exper == 1 && exper1 == 10
        nAnts = [20 40 60 80 100 200 300 400 500 1000]; lnAnts = length(nAnts);
        ResF = 'AllResofExptenA';
    elseif exper == 2
        nAnts = [20 40 60 80 100 200 300 400 500 1000]; lnAnts = length(nAnts);
        ResF = 'AllResofExptenB';
    end
    legendInfo=zeros(0,1);  legendInfot = zeros(0,1); legendInfomin=zeros(0,1); columnLabels=zeros(0,1);
    %ResF = 'AllResofExpten';
	% Intialisation matrix results
    AS_BestCost_for_nb_exec =  zeros(nb_exec, MaxIt);
    % Execution time with Ants variation, Mean and STD  
    AS_Exec_Time_Varying_nAnts=zeros(0,1); % Execution time with ants variation

%% All the programm 
for i=1:SofF2test(2)
    %% name the folder of exp and choose the file of exp and name the workspace ...
    filename=Files2Test{i};
    spltfilename = strsplit(filename,'.');
    if exper==1
        FName = strcat('ResultOf',spltfilename{1},'Nvariation');
    elseif exper==2
        FName = strcat('ResultOf',spltfilename{1});
    end
    %	FName = strcat('Result_of_',spltfilename{1},'Nvariation');
    mkdir(ResF,FName);
    CurrentF = pwd;
    F2SaveRes= strcat(CurrentF,'\',ResF, strcat('\', FName));
    fnamefigures = F2SaveRes;
    workspaceFN =strcat('_with_','alpha=',num2str(alpha),'_beta=',num2str(beta),'_tmax=',num2str(MaxIt));
    Nofworkspace = strcat(F2SaveRes,'\',FName,workspaceFN);

    %% Run the algorithm
    for exec=1:nb_exec
        if exper==1
            Antsnumber= nAnts(exec);
        elseif exper==2
            Antsnumber= 40;
        end
        tic
        [AS_SeqSolBestf, AS_Bestf, AS_BestCost, cities, model] = aco(filename, Antsnumber, alpha, beta, rho, MaxIt);
        AS_Exec_Time_Varying_nAnts(exec) = toc;
        AS_BestCost_for_nb_exec(exec,:) = AS_BestCost;
        %     AS_BestCost(nb_exec) = AS_BestCost(1,end);
        AS_BestCost(nb_exec) = min(AS_BestCost);
    end
    %% Extract result of the algorithm after running 
    AS_Mean_for_Time_Exec = mean(AS_Exec_Time_Varying_nAnts);
    AS_STD_for_Time_Exec = std(AS_Exec_Time_Varying_nAnts);
    AS_Mean_BestCost_for_nb_exec = mean(AS_Exec_Time_Varying_nAnts);
    AS_STD_BestCost_for_nb_exec = std(AS_BestCost);

    %% Plot reuslt of path journey and extract as .eps .jpg and .figure
    figofpath = showPlot(cities,AS_SeqSolBestf);hold on;
    figtitnamec = filename;    
    title([figtitnamec,', ','Path = ',num2str(min(AS_BestCost))]); hold off;
    
    print(fullfile(fnamefigures,strcat('path')),'-depsc')
    print(fullfile(fnamefigures,strcat('path')),'-djpeg')
    saveas(figofpath,fullfile([strcat(fnamefigures,'\') 'path.fig']))

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
    figname = strcat('AS','_',num2str(alpha),'_',num2str(beta),'AS_ExecTimeAndMeanSTDWith_execVariation');
    print(fullfile(fnamefigures,figname),'-depsc')
    print(fullfile(fnamefigures,figname),'-djpeg') 
    fignametosave = char(strcat(figname,'.fig'));
    savefig(fig2,fullfile(fnamefigures,fignametosave),'compact') 
    %% figmin, the figure of the execution that converge for the first time and the figure of the one which converge firsty
    if exper==1
        %% fig1, the figure of best cost vs iteration number with variation nb ants (exp1) and best cost vs  iteration fixing nb ants 
        fig1 = figure;hold on
        for exec=1:nb_exec
            plot(1:1:MaxIt,AS_BestCost_for_nb_exec(exec,:),'-o',...
                'LineWidth',1.5,...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
            if exper==2
                legendInfot{exec} = [ num2str(exec) ' nth execution'];
                titlefig = [figtitnamec,', ','Best Cost on',' ',num2str(nb_exec),' execution '];
            elseif exper==1 
                legendInfot{exec} = [ num2str(nAnts(exec)) ' ants'];
                titlefig = [figtitnamec,', ','The Best Cost  VS Ants number variation on ',num2str(MaxIt), ' Iteration'];
            end
            title(titlefig);
            legend(legendInfot);
            xlabel('Iteration'); 
            ylabel('Best cost');
            grid on;
        end
        for k=1:(size(AS_BestCost_for_nb_exec,1)-2):size(AS_BestCost_for_nb_exec,1)
            for j=1:size(AS_BestCost_for_nb_exec,2)
                BestCost = [' \leftarrow', num2str(AS_BestCost_for_nb_exec(k,j))];
                text(j,AS_BestCost_for_nb_exec(k,j),BestCost,'Rotation',45);
            end
        end
        figname1 = ['AS','_BestCost_Varying_Iteration_and_nbAnts'];
        print(fullfile(fnamefigures,figname1),'-depsc')
        print(fullfile(fnamefigures,figname1),'-djpeg')
        fignametosave1 = [figname1,'.fig'];
        savefig(fig1,fullfile(fnamefigures,fignametosave1),'compact')
        %% figmin, the figure of the execution that converge for the first time and the figure of the one which converge firsty 
        figmin = figure;hold on
% %         X=AS_BestCost_for_nb_exec;
% %         for ii=1:size(AS_BestCost_for_nb_exec,1)
% %             [minX, ind] = min(X(ii,:),[],2);
% %             MminB(1,ii)=minX;
% %             MminB(2,ii)=ind;
% %         end
% %         %[~, indexo] = min(MminB(2,:),[],2);    
% %         [~, indexo] = min(MminB(1,:),[],2);
% %         % index6 = MminB(2,indexo)
% %         index6=indexo;
        index6=9;
        plot(1:1:10,AS_BestCost_for_nb_exec(index6,:),'-o',...
                   'LineWidth',1.5,...
                   'MarkerFaceColor','g',...
                   'MarkerSize',5);
           for il=index6
               for j=1:size(AS_BestCost_for_nb_exec,2)
                   BestCost = [' \leftarrow', num2str(AS_BestCost_for_nb_exec(index6,j))];
                   text(j,AS_BestCost_for_nb_exec(il,j),BestCost,'Rotation',45);
               end
           end
       legendInfomin= zeros(0,1);
       if exper==2
           legendInfomin{exec} = [ num2str(exec) ' nth execution'];
           titlefig = [figtitnamec,', ','Best Cost on',' ',num2str(nb_exec),' execution '];
       elseif exper==1

           legendInfomin= [ num2str(index6*20) ' ants'];
           %{legendInfomin{2}= [ num2str(indofminindex1*20) ' ants'];
           %}
           titlefig = [figtitnamec,', ','The Best Cost  of the first exec and the end exec'];
       end
       title(titlefig); legend(legendInfomin); xlabel('Iteration');    ylabel('Best cost');    grid on;
       figname3 = ['AS',num2str(alpha),num2str(beta),'ExecAcheivingBestCost'];
       print(fullfile(fnamefigures,figname3),'-depsc')
       print(fullfile(fnamefigures,figname3),'-djpeg')
       fignametosave3 = char(strcat(figname3,'.fig'));
       savefig(figmin,fullfile(fnamefigures,fignametosave3),'compact')      
    elseif exper==2
        %% fig1, the figure of best cost vs iteration number with variation nb ants (exp1) and best cost vs  iteration fixing nb ants 
        fig1 = figure;hold on
        for exec=1:nb_exec
            plot(1:1:MaxIt,AS_BestCost_for_nb_exec(exec,:),'-o',...
                'LineWidth',1.5,...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
            if exper==2
                legendInfot{exec} = [ num2str(exec) ' nth execution'];
                titlefig = [figtitnamec,', ','Best Cost on',' ',num2str(nb_exec),' execution '];
            elseif exper==1 
                legendInfot{exec} = [ num2str(nAnts(exec)) ' ants'];
                titlefig = [figtitnamec,', ','The Best Cost  VS Ants number variation on ',num2str(MaxIt), ' Iteration'];
            end
            title(titlefig);
            legend(legendInfot);
            xlabel('Iteration'); 
            ylabel('Best cost');
            grid on;
        end
        for k=1:(size(AS_BestCost_for_nb_exec,1)-2):size(AS_BestCost_for_nb_exec,1)
            for j=1:size(AS_BestCost_for_nb_exec,2)
                BestCost = [' \leftarrow', num2str(AS_BestCost_for_nb_exec(k,j))];
                text(j,AS_BestCost_for_nb_exec(k,j),BestCost,'Rotation',45);
            end
        end
        figname1 = ['AS','_BestCost_Varying_Iteration_and_nbAnts'];
        print(fullfile(fnamefigures,figname1),'-depsc')
        print(fullfile(fnamefigures,figname1),'-djpeg')
        fignametosave1 = [figname1,'.fig'];
        savefig(fig1,fullfile(fnamefigures,fignametosave1),'compact')
    end
    
    %% Produce latex table
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
    save(Nofworkspace)
    close all
end