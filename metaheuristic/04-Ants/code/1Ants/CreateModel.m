function model=CreateModel(filename)
% %     filename= 'rnd_50.dat';
    citiesdata = importdata(filename);
    if strcmp(filename, 'cities.dat') == true || strcmp(filename, 'cities2.dat') == true
        cities = citiesdata.data();
        xc = citiesdata.data(:,1);
        yc = citiesdata.data(:,2);
        x=xc';
        y=yc';
    else
        cities = citiesdata(:,2:3);
        xc = citiesdata(:,2);
        yc = citiesdata(:,3);
        x=xc';
        y=yc';
    end
     


%     x=[82 91 12 92 63 9 28 55 96 97 15 98 96 49 80 14 42 92 80 96];
%     
%     y=[66 3 85 94 68 76 75 39 66 17 71 3 27 4 9 83 70 32 95 3];
    
    n=numel(x);
    
    D=zeros(n,n);
    
    for i=1:n-1
        for j=i+1:n
            
            D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            
            D(j,i)=D(i,j);
            
        end
    end
    
    model.cities=cities;
    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;

end