function [ figpath ] = showPlot(cities,sol)

% figpath = figure;
figpath = figure;
title('Path')
axis equal
hold on
%% Original function plot
% plot(cities([sol(1) sol(end)],1), cities([sol(1) sol(end)],2), '.--')
% for i = 2:length(sol)
%   plot(cities(sol(i-1:i),1), cities(sol(i-1:i),2), '.--');
% end

%% Updated function plot
plot(cities([sol(1) sol(end)],1), cities([sol(1) sol(end)],2),'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','y',...
        'LineWidth',1.5)

    

for i = 2:length(sol)
  plot(cities(sol(i-1:i),1), cities(sol(i-1:i),2),'k-o',...
        'MarkerSize',10,...
        'MarkerFaceColor','y',...
        'LineWidth',1.5);
end
    xlabel('x');
    ylabel('y');  
%     axis equal;
%     grid on;
hold off

end