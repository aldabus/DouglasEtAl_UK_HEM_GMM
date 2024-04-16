function [acc,sd]=raeng_getpsa(cinfile,M,d)

% Reading in the coefficients
fid=fopen(cinfile,'rt');
runpar=fscanf(fid,'%f %f %f %f',[4 inf]);
cchar=' ';
while cchar~='c'
    cchar=fscanf(fid,'%c',[1,1]);
end
switch runpar(1)
    case {1,4}
        nc=5;
    case {2,5,7,8}
        nc=4;
    case {3}
        nc=6;
    case {6}
        nc=3;
    case {9}
        nc=7;
    case {10}

    case {11}
        nc=10;
    case {12}
        nc=9;
end
switch runpar(3)
    case {1,2}
        nc=nc+2;
end
switch runpar(2)
    case {1}
        nsd=1;
    case{2,3,4}
        nsd=2;
    case {5}
        nsd=3;
end
% switch runpar(2)
%     case {1}
%         nsd=1;
%     case{2,3,4}
%         nsd=2;
%     case {5}
%         nsd=3;
% end




data=fscanf(fid,'%f',[3*nc+nsd+6 inf]);
fclose(fid);
switch runpar(2)
    case {1}
        sd=data(3+nc,:);
    case {2,3,4}
        sd1=data(3+nc,:);
        sd2=data(3+nc+1,:);
        sd=sqrt(sd1.^2+sd2.^2);
    case {5}
        sd1=data(3+nc,:);
        sd2=data(3+nc+1,:);
        sd3=data(3+nc+2,:);
        sd=sqrt(sd1.^2+sd2.^2+sd3.^2);
end
b=data(3:3+nc-1,:);

switch runpar(1)
    case {1}
        func1=@attfunmga;
    case {2}
        func1=@attfunmg;
    case {3}
        func1=@attfunmqga;
    case {4}
        func1=@attfunmqg;
    case {5}
        func1=@attfunnmga;
    case {6}
        func1=@attfunnmg;
    case {7}
        func1=@attfunmm1a;
    case {8}
        func1=@attfunmgd;
    case {9}
        func1=@attfunct;
    case {10}

    case {11}
        func1=@attfuncampbell;
    case {12}
        func1=@attfunspain;
end

if runpar(3)==-1
    [acc,~]=feval(func1,[M,d],b);
end

acc=exp(acc);
