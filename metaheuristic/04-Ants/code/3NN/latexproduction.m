%fnamefigures = 'C:\Users\mod\OneDrive\2015-2016\Uni\AutumnSem2015\1 - MHOA\MHOA\TP\TP4_MHOA\code\AllResofExpfiveGreedy';
fnamefiguresa = 'C:\Users\mod\OneDrive\2015-2016\Uni\AutumnSem2015\1 - MHOA\MHOA\TP\TP4_MHOA\code\3NN\AllResofExpfiveGreedy';
fnamefigures = [fnamefiguresa,'\','ResultOf80' ];

%% Produce latex table
% %     % Matrix of Best cost  VS variation of ants number on MaxIt
% %     matrix = AS_BestCost_for_nb_exec;
% %     rowLabels= cell(1,nb_exec);
% %     for s=1:nb_exec
% %         rowLabels{s} = strcat('exec : ', num2str(s));
% %     end
% %     for u=1:MaxIt
% %         columnLabels{u} = strcat('It : ', num2str(u));
% %     end
% % 
% %     texAS_BestCostfile=  strcat(spltfilename{1},'_','AS_BestCost_for_nb_exec.tex');
% %     matrix2latex(matrix, texAS_BestCostfile, 'rowLabels', rowLabels, 'columnLabels', columnLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'tiny'); 
% %     movefile(texAS_BestCostfile,strcat(fnamefigures,'\'))
    
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