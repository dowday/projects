clc
clear
close all
ResF = 'Results';
FName = 'ResVisual';
mkdir(ResF,FName);
CurrentF = pwd;
F2SaveRes= strcat(CurrentF,'\',ResF, strcat('\', FName));
fnamefigures = F2SaveRes;
x = 10:1000 ; 
y = 10:1000 ;
[X,Y] = meshgrid(x,y);
z = -abs(0.5.*X.*sin(sqrt(abs(X))))-abs(Y.*sin(30.*sqrt(abs(X./Y))));
%%
fig1 = figure;
surf(X,Y,z);
colorbar;
shading interp 
axis on vis3d;
grid on
title(sprintf('The minimum is %f', min(z(:))))
% shading flat 
% shading faceted 
figname1 = 'Visualisation3D' ;
print(fullfile(fnamefigures,figname1),'-depsc')
print(fullfile(fnamefigures,figname1),'-djpeg')
fignametosave1 = [char(figname1),'.fig'];
savefig(fig1,fullfile(fnamefigures,fignametosave1),'compact')
fig2 = figure; hold on
surf(X,Y,z);
colorbar;
shading interp 
axis on vis3d;

grid on
title(sprintf('The minimum is %f', min(z(:))))
figname1 = 'VisualisationMin' ;
print(fullfile(fnamefigures,figname1),'-depsc')
print(fullfile(fnamefigures,figname1),'-djpeg')
fignametosave1 = [char(figname1),'.fig'];
savefig(fig1,fullfile(fnamefigures,fignametosave1),'compact')