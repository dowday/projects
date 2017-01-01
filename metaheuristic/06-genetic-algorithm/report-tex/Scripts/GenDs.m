function [ X ] = GenDs( d )
%GENERATEDSAMPLES Summary of this function goes here
%   Detailed explanation goes here
n=1000;
X = zeros(d,n);
    for i=1:d
        for j=1:n
           X(i,j)=round(rand(1));
        end
    end
X=X';

end