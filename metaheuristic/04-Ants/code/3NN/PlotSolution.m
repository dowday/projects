function PlotSolution(resultnn)

%     optRoute=[optRoute optRoute(1)];
    
    optRoute=resultnn.optRoute;
    X=resultnn.xy(:,1)';
    Y=resultnn.xy(:,2)';
    plot(X(optRoute),Y(optRoute),'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','y',...
        'LineWidth',1.5);
    
    xlabel('x');
    ylabel('y');
    
    axis equal;
    grid on;
    
	alpha = 0.1;
	
    xmin = min(X);
    xmax = max(X);
    dx = xmax - xmin;
    xmin = floor((xmin - alpha*dx)/10)*10;
    xmax = ceil((xmax + alpha*dx)/10)*10;
    xlim([xmin xmax]);
    
    ymin = min(Y);
    ymax = max(Y);
    dy = ymax - ymin;
    ymin = floor((ymin - alpha*dy)/10)*10;
    ymax = ceil((ymax + alpha*dy)/10)*10;
    ylim([ymin ymax]);
    
    
end