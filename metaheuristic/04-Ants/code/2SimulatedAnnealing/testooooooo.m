
close all
figure;
tt=1:1:100;
a=BestCost'
plot(tt,a,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
% % grid on;

 for k=10:10:size(a,2)
    for j=1:20:100
        BestCostname = [' \leftarrow ', num2str(a(1,j))];
        text(j,a(1,j),BestCostname,'Rotation',20);
    end
 end