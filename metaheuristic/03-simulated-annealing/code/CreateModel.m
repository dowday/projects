function model = CreateModel( filename )

    citiesdata = importdata(filename);
    ct = citiesdata.data;
    cities = ct;
    citiesnames = citiesdata.textdata;
%     cititesname = 'ctNA';
    x = ct(:,1)';
    y = ct(:,2)';
    
    n=numel(x);
    
    d=zeros(n,n);
    
    for i=1:n-1
        for j=i+1:n
            d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            d(j,i)=d(i,j);
        end
    end
%     xmin=min(x);
%     xmax=max(x);
%     
%     ymin=min(y);
%     ymax=max(y);
% %     xmin=0;
% %     xmax=6;
% % 
    ymin=0;
    ymax=100;
    xmin=0;
    xmax=215;
% 
%     ymin=0;
%     ymax=0;
    model.n=n;
    model.x=x;
    model.y=y;
    model.d=d;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;

    model.cities=cities;
    model.citiesnames = citiesnames;
    
end