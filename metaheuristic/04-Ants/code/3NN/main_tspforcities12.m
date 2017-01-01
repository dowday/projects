clc;
clear;
close all;
% n=40;
tprob = [20 50 60 80 100];
nb_exec=size(tprob,2);
ResF = 'AllResofExpfiveGreedy';
Files2Test = {'cities.dat', 'cities2.dat', 'rnd50.dat', 'rnd60.dat', 'rnd80.dat', 'rnd100.dat'};
%Files2Test = {'cities.dat'};
SofF2test = size(Files2Test,2);
for file=1:size(Files2Test,2)
    filename = char(Files2Test(file));
    spltfilename = strsplit(filename,'.');
    FName = ['ResultOf',char(spltfilename{1})];
    a = importdata(filename);
    if strcmp(filename, 'cities.dat') == 1 ||  strcmp(filename, 'cities2.dat') == 1 
        cities = a.data;
    else
        cities = a(:,2:3); % for the rand problem
    end
    for tt=1:1
    %    FName= ['ResultOf','citiescinq'];
        tpNNexecution= zeros(1,size(tprob,2));
        mkdir(ResF,FName);
        CurrentF = pwd;
        F2SaveRes= strcat(CurrentF,'\',ResF, strcat('\', FName));
        %fnamefigures = 'C:\Users\mod\OneDrive\2015-2016\Uni\AutumnSem2015\1 - MHOA\MHOA\TP\TP4_MHOA\code\tsp_nn';
        %Nofworkspace = [fnamefigures,'\',FName];
        figtitnamec=['NN-',spltfilename{1}];
    % %     for exec=1:nb_exec
    %    userConfig= struct('xy',a(:,2:3));hold off;
        tic
        [sol2, f2] = nn(cities);
        tpNNexecution(tt) = toc;


        figuro = showPlot(cities, sol2);title(sprintf('Total distance =  %d', f2));hold on
        %saveas(figuro,sprintf('path.eps'))
        %movefile('path.eps',[pwd, '\', ResF,'\', FName, '\' ])
        saveas(figuro,sprintf('path.jpg'))
        movefile('path.jpg',[pwd, '\', ResF,'\', FName, '\' ])
        saveas(figuro,sprintf('path.fig'))
        movefile('path.fig',[pwd, '\', ResF,'\', FName, '\' ])
    % %     end
        NN_Mean_for_Time_Exec= mean(tpNNexecution);
        NN_STD_for_Time_Exec = std(tpNNexecution);
        fig2 = figure; hold on;
        plot(1:1:nb_exec, tpNNexecution,'-o',...
                               'LineWidth',2,...
                               'MarkerEdgeColor','k',...
                               'MarkerFaceColor','g',...
                               'MarkerSize',5);
        for t=1:nb_exec
            std_time_exec = ['\uparrow', num2str(tpNNexecution(t))];
            text(t,tpNNexecution(t),std_time_exec,'VerticalAlignment','cap');
        end
        stepz(NN_Mean_for_Time_Exec);hold on
        Mean_time_exec = [' \leftarrow Mean time execution = ', num2str(NN_Mean_for_Time_Exec)];
        text(0,NN_Mean_for_Time_Exec,Mean_time_exec,'Rotation',0);
        stepz(NN_STD_for_Time_Exec); hold on
        std_time_exec = ['  \leftarrow STD of time execution = ', num2str(NN_STD_for_Time_Exec)];
        text(0,NN_STD_for_Time_Exec,std_time_exec,'Rotation',0);
        title([figtitnamec,', ','The Time Execution for, Mean and STD'])
        xlabel('Execution number');
        ylabel('Time');
        grid on;
           % Save figures
        figname = 'ExecTimeAndMeanSTDWith';
       
        %saveas(fig2,sprintf('ExecTimeAndMeanSTDWith.eps'))
        saveas(fig2,sprintf('ExecTimeAndMeanSTDWith.jpg'))
        movefile('ExecTimeAndMeanSTDWith.jpg',[pwd, '\', ResF,'\', FName, '\' ])
        saveas(fig2,sprintf('ExecTimeAndMeanSTDWith.fig'))
        movefile('ExecTimeAndMeanSTDWith.fig',[pwd, '\', ResF,'\', FName, '\' ])
        print('ExecTimeAndMeanSTDWith','-depsc')
%        saveas(fig2,['ExecTimeAndMeanSTDWith','.eps'],'eps')  
%         set(fig2,'TickLabelInterpreter', 'latex')
%         saveas(gca, 'myplot.eps','eps')
%        movefile('ExecTimeAndMeanSTDWith.eps',[pwd, '\', ResF,'\', FName, '\' ])
        save([pwd, '\', ResF,'\', FName])
    end
    close all
end