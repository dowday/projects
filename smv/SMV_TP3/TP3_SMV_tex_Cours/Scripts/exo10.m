
clc;
close all;

D = pdist(X);
figure; hist(D(:));

d=1000;
Dnn=zeros(1,5);
X=GenDs(d);
D = pdist(X);

