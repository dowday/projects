function y=Deltai( Position,cost )
%DELTAI Summary of this function goes here
%   Detailed explanation goes here
p1 =[ 1     2     3     5     4     6     7     8     9     4     5     1];
    for i=1:nActions
            mk=ActionList{i};
            newsol.Position=DoSwap(sol.Position,mk(1,1),mk(1,2));
%             newsol.Cost(i)=CostFunction(newsol.Position) + newsol.Delta;
            newsol.ActionIndex=i;
            newsol.Delta(i)= newsol.Cost(i) - sol.Cost;
    end
end

