function [ N ] = NABRS( p1 )
%NABRS Summary of this function goes here
%   Detailed explanation goes here
    n=numel(p1);
    nActions= (n*(n-1))/2; % all possible neighbours of p1
    ActionList=CreatePermActionList(n);
    N=zeros(nActions,n);
    for i=1:nActions
        mk=ActionList{i};
        p=DoSwap(p1,mk(1,1),mk(1,2));
        N(i,:)=p(1,:);
    end
end

