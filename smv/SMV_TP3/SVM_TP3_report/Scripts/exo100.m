clc;
close all;

d=1;
Dnn=zeros(1,5);
X=GenDs(d);
D = pdist(X);
hist(D(:))