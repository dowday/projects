
function [varargout] = tsp_nn(varargin) 
    tprob = [20 50 60 80 100];
    a=importdata('cities2.dat')
    cities=a.data;
    nb_exec=size(tprob,2);
    ResF = 'AllResofExpfiveF';
    for tt=1:5
        FName= ['ResultOf','citiesdeux'];
    end
    tpNNexecution= zeros(1,size(tprob,2));
    mkdir(ResF,FName);
    CurrentF = pwd;
    F2SaveRes= strcat(CurrentF,'\',ResF, strcat('\', FName));
    Nofworkspace = [pwd,'\',ResF,'\',FName]
    % Initialize default configuration
    defaultConfig.xy          = cities;
    defaultConfig.dmat        = [];
    defaultConfig.popSize     = Inf;
    defaultConfig.showProg    = true;
    defaultConfig.showResult  = true;
    defaultConfig.showWaitbar = false;
    
    % Interpret user configuration inputs
    if ~nargin
        userConfig = struct();
    elseif isstruct(varargin{1})
        userConfig = varargin{1};
    else
        try
            userConfig = struct(varargin{:});
        catch
            error('Expected inputs are either a structure or parameter/value pairs');
        end
    end
    
    % Override default configuration with user inputs
    configStruct = get_config(defaultConfig,userConfig);
    
    % Extract configuration
    xy          = configStruct.xy;
    dmat        = configStruct.dmat;
    popSize     = configStruct.popSize;
    showProg    = configStruct.showProg;
    showResult  = configStruct.showResult;
    showWaitbar = configStruct.showWaitbar;
    
    
    if isempty(dmat)
        nPoints = size(xy,1);
        a = meshgrid(1:nPoints);
        dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),nPoints,nPoints);
    end
    
    % Verify Inputs
    [N,dims] = size(xy);
    [nr,nc] = size(dmat);
    if N ~= nr || N ~= nc
        error('Invalid XY or DMAT inputs!')
    end
    n = N;
    
    % Sanity Checks
    popSize     = max(1,min(n,round(real(popSize(1)))));
    showProg    = logical(showProg(1));
    showResult  = logical(showResult(1));
    showWaitbar = logical(showWaitbar(1));
    
    % Initialize the Population
    pop = zeros(popSize,n);
    
    % Run the NN
    distHistory = zeros(1,popSize);
%     if showProg
%         figure('Name','TSP_NN | Current Solution','Numbertitle','off');
	hAx = gca;
%     end
    if showWaitbar
        hWait = waitbar(0,'Searching for near-optimal solution ...');
    end
    for p = 1:popSize
        d = 0;
        thisRte = zeros(1,n);
        visited = zeros(1,n);
        I = p;
        visited(I) = 1;
        thisRte(1) = I;
        for k = 2:n
            dists = dmat(I,:);
            dists(logical(visited)) = NaN;
            dMin = min(dists(~visited));
            J = find(dists == dMin,1);
            visited(J) = 1;
            thisRte(k) = J;
            d = d + dmat(I,J);
            I = J;
        end
        d = d + dmat(I,p);
        pop(p,:) = thisRte;
        distHistory(p) = d;
        
% %         if showProg
% %             % Plot the Current Route
% %             rte = thisRte([1:n 1]);
% %             if dims > 2, plot3(hAx,xy(rte,1),xy(rte,2),xy(rte,3),'k-o',...
% %                     'MarkerSize',10,...
% %                     'MarkerFaceColor','y',...
% %                     'LineWidth',1.5);
% %             else plot(hAx,xy(rte,1),xy(rte,2),'k-o',...
% %                     'MarkerSize',10,...
% %                     'MarkerFaceColor','y',...
% %                     'LineWidth',1.5);grid on;
% %             end
% %             title(hAx,sprintf('Total Distance = %1.4f',distHistory(p)));
% %             drawnow;
% %         end
        
        % Update the waitbar
        if showWaitbar && ~mod(p,ceil(popSize/325))
            waitbar(p/popSize,hWait);
        end
        
    end
% %     if showWaitbar
% %         close(hWait);
% %     end
    hold off;
    % Find the Minimum Distance Route
    [minDist,index] = min(distHistory);
    optRoute = pop(index,:);

    if showResult
        if showProg
            % Plot the Best Route
            rte = optRoute([1:n 1]);
            if dims > 2, plot3(hAx,xy(rte,1),xy(rte,2),xy(rte,3),'k-o',...
                    'MarkerSize',10,...
                    'MarkerFaceColor','y',...
                    'LineWidth',1.5);
            else plot(hAx,xy(rte,1),xy(rte,2),'k-o',...
                    'MarkerSize',10,...
                    'MarkerFaceColor','y',...
                    'LineWidth',1.5);grid on;
            end

            title(hAx,sprintf('Total Distance = %1.4f',minDist));hold off
        end
        % Plots the NN Results
        fig3= figure;
        pclr = ~get(0,'DefaultAxesColor');
        if dims > 2, plot3(xy(:,1),xy(:,2),xy(:,3),'.','Color',pclr);
        else plot(xy(:,1),xy(:,2),'.','Color',pclr);grid on;
        end
        rte = optRoute([1:n 1]);
        if dims > 2, plot3(xy(rte,1),xy(rte,2),xy(rte,3),'k-o',...
                'MarkerSize',10,...
                'MarkerFaceColor','y',...
                'LineWidth',1.5);
        else plot(xy(rte,1),xy(rte,2),'k-o',...
                'MarkerSize',10,...
                'MarkerFaceColor','y',...
                'LineWidth',1.5);grid on;
        end
        title(sprintf('Total Distance = %1.4f',minDist));
        xlabel('X');
        ylabel('Y');
        grid on;hold off;
        figname = ['Totaldist'];
        print(fullfile(Nofworkspace,figname),'-depsc')
        print(fullfile(Nofworkspace,figname),'-djpeg') 
        fignametosave = char(strcat(figname,'.fig'));
        savefig(fig3,fullfile(Nofworkspace,fignametosave),'compact') 
        
        fig0=figure;
        plot(sort(distHistory,'descend'),'LineWidth',2);grid on;
        title('Distances');
        set(gca,'XLim',[0 popSize+1],'YLim',[0 1.1*max([1 distHistory])]);
        xlabel('Iteration');
        ylabel('Best Cost');
        fig2=figure;
        plot(size(distHistory,2)); hold on;
        plot(sort(distHistory,'descend'),'LineWidth',2);
        set(gca,'XLim',[0 popSize+1],'YLim',[0 1.1*max([1 distHistory])]);
        xlabel('Iteration');
        ylabel('Best Cost');
        grid on;hold off
        figname = ['DistVSIt'];
        fnamefiguresp=[pwd,'\'];
        print(fullfile(fnamefiguresp,figname),'-depsc')
        print(fullfile(fnamefiguresp,figname),'-djpeg') 
        fignametosave = char(strcat(figname,'.fig'));
        savefig(fig0,fullfile(fnamefiguresp,fignametosave),'compact') 
        
        
    end
    
    % Return Output
    if nargout
        resultStruct = struct( ...
            'xy',          xy, ...
            'dmat',        dmat, ...
            'popSize',     popSize, ...
            'showProg',    showProg, ...
            'showResult',  showResult, ...
            'showWaitbar', showWaitbar, ...
            'optRoute',    optRoute, ...
            'minDist',     minDist, ...
            'pop',         pop, ...
            'distHistory', distHistory);
            
        varargout = {resultStruct};
    end
    
end

% Subfunction to override the default configuration with user inputs
function config = get_config(defaultConfig,userConfig)
    
    % Initialize the configuration structure as the default
    config = defaultConfig;
    
    % Extract the field names of the default configuration structure
    defaultFields = fieldnames(defaultConfig);
    
    % Extract the field names of the user configuration structure
    userFields = fieldnames(userConfig);
    nUserFields = length(userFields);
    
    % Override any default configuration fields with user values
    for i = 1:nUserFields
        userField = userFields{i};
        isField = strcmpi(defaultFields,userField);
        if nnz(isField) == 1
            thisField = defaultFields{isField};
            config.(thisField) = userConfig.(userField);
        end
    end
    
end

