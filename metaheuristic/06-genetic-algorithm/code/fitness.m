function f = fitness( x,y )
if (x<10 || x>1000) || (y<10 || y>1000)
    %we exclude values below 10 and above 1000
    f = Inf;
else
    f = -abs(0.5*x*sin(sqrt(abs(x))))-abs(y*sin(30*sqrt(abs(x/y))));
end

end

