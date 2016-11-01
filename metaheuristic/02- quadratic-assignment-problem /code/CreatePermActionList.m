function ActionList=CreatePermActionList(n)

    nSwap=n*(n-1)/2;
%     nReversion=n*(n-1)/2;
%     nInsertion=n^2; %u
%     nAction=nSwap+nReversion+nInsertion;
    nAction=nSwap;%+nReversion+nInsertion;
    
    ActionList=cell(nAction,1);
    
    c=0;
    
    % Add SWAP
    for i=1:n-1
        for j=i+1:n
            c=c+1;
            ActionList{c}=[i j];
        end
    end
end