function vp=DoSwap(p,m1,m2)
    v1= p(m1);
    v2= p(m2);
    p(1,m1)=v2;
    temp=p;
    temp(1,m2)=v1;
    vp=temp;
end