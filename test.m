
Mw=6.5;
Rjb=-1;
Rrup=80;
T = [0.01,0.025,0.05,0.075,0.10,0.15,0.20,0.30,0.40,0.50,0.75,1.0,1.5,2.0,3.0,4.0,5.0,7.5,10];
model=162;
branch=1:162;
weightopt='original'; %'reweighted' or 'original'

for mi = 1:162
    for ti = 1:length(T)
        acc(ti) = DATDT24(Mw,Rjb,Rrup,T(ti),model,branch(mi),weightopt);
    end
    if mi < 82
        semilogx(T,acc,'k-')
    else
        semilogx(T,acc,'g--')
    end
    if mi == 1
        hold on
    end
end
