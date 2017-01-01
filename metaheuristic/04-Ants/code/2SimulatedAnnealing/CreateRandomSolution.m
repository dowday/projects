function sol=CreateRandomSolution(model)

%% sol ori 
%     n=model.n;
%     sol=randperm(n);

%% me sol

    citiesnames=model.citiesnames;
    ordering = randperm(numel(citiesnames))';
    sol =ordering';
end