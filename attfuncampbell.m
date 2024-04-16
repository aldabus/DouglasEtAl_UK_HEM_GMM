function [f0,z0]=attfuncampbell(xi,theta)
% ---------------------------------------------------------------------------
% [F0,Z0]=ATTFUNMQA(XI,THETA)
% Input:
% XI=2x1 vector of magnitude and distance for station
% THETA=10x1 vector of current estimates of coefficients
% Output:
% F0=Estimated acceleration at station using current coefficients
% Z0=10x1 vector of derivatives w.r.t. coefficients at currect station
%
% Campbell (2003)'s functional form
%
% Author: J. Douglas
%
% History:
% -  5.11.2003: Created
% 
% Last revision:  5.11.2003
% --------------------------------------------------------------------------

z0=zeros(1,10);

r1=50;
r2=100;

if xi(2)<=r1
 f3=0;
 z0(9)=0;
 z0(10)=0;
elseif and(xi(2)>r1,xi(2)<=r2)
 f3=theta(9)*(log(xi(2))-log(r1));
 z0(9)=log(xi(2))-log(r1);
 z0(10)=0;
else
 f3=theta(9)*(log(xi(2))-log(r1))+theta(10)*(log(xi(2))-log(r2));
 z0(9)=log(xi(2))-log(r1);
 z0(10)=log(xi(2))-log(r2);
end
         
f0=theta(1)+theta(2)*xi(1)+theta(3)*(8.5-xi(1))^2+theta(4)*log(sqrt(xi(2)^2+(theta(7)*exp(theta(8)*xi(1)))^2))+(theta(5)+theta(6)*xi(1))*xi(2)+f3;

z0(1)=1;
z0(2)=xi(1);
z0(3)=(8.5-xi(1))^2;
z0(4)=log(sqrt(xi(2)^2+(theta(7)*exp(theta(8)*xi(1)))^2));
z0(5)=xi(2);
z0(6)=xi(1)*xi(2);
z0(7)=theta(4)*theta(7)*(exp(theta(8)*xi(1)))^2/(xi(2)^2+(theta(7)*exp(theta(8)*xi(1)))^2);
z0(8)=theta(4)*xi(1)*(theta(7)*exp(theta(8)*xi(1)))^2/(xi(2)^2+(theta(7)*exp(theta(8)*xi(1)))^2);
