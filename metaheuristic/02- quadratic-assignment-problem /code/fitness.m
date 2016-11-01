function [ f ] = fitness( p,model )
%FINDPOS Summary of this function goes here
%   Detailed explanation goes here
F=0;
n=numel(p);
    for i=1:n
        for j=1:n
            ri= p==i;
            rj= p==j;
            F=F+(model.D(ri,rj))*(model.W(i,j));
        end
    end
    f=F;
end

