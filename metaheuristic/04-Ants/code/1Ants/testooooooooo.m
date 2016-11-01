% % A=AS_BestCost_for_nb_exec;
% % [minA ind] = min(A,1)
% % [minA ind] = min(A,[],2)
% % [minA ind] = min(A)
    %{
    [meaneachrow1, indel2]= min(mineachrow);
    [minindex1, indofminindex1] = min(index1);
    [meaneachrow2, indexc3]= min(min(AS_BestCost_for_nb_exec));
    %}
MminB= zeros (2,5)
b= zeros (1,5)
X=AS_BestCost_for_nb_exec
for i=1:5
    [minA ind] = min(AS_BestCost_for_nb_exec(i,:))
    MminB(1,i)=minA
    MminB(2,i)=ind
end
[~, indexo] = min(MminB(2,:))
index6 = MminB(2,indexo)
%{
for i=1:5
    for j=2:5
        if a(i)<a(j)
            b= a(i-1);
            break
        end
    end
end
%}

for i=1:5
    find(X(i,:)== min(X(i,:)))
end
%{
a=[29.5145889715325,29.4647118789580,27.5153625634254,27.5153625634254,27.5153625634254,27.5153625634254,27.5153625634254,27.5153625634254,27.5153625634254,27.5153625634254]
a1= AS_BestCost_for_nb_exec(4,:)
[c d ] = min(a)
[c1 d1] = min(a1)
%}
% % 
% % [minMat, Ind] = min(min(A(1,:),2));
% % [minInd, ~] = min(Ind);
% % for ll=1:10
% %     for jj=1:5
% %         A(jj,ll)
% %         if A(jj,ll) == minMat
% %             l=Ind(ll);l
% %         else
% %             break;
% %         end
% %     end
% % end