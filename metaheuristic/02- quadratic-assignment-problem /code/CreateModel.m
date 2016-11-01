function model = CreateModel(filename)
    A=dlmread(filename);  
    n=A(1,1);
    D=A(2:n+1,:);
    W=A(n+2:end,:);

    model.n=n;
    model.D=D;
    model.W=W;
    
end