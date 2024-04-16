function acc=raeng_backbone_model(Mw,Rjb,T,branch,numberbranch,weightopt)

directory=strcat(cd,'\FinalCoefficients\');
stemcoeff=['coeffukboth_',num2str(numberbranch,'%1i'),'branches_',weightopt,'_'];
periods=[{'0010'},{'0025'},{'0050'},{'0075'},{'0100'},{'0150'},{'0200'},{'0300'},{'0400'},{'0500'},{'0750'},{'1000'},{'1500'},{'2000'},{'3000'},{'4000'},{'5000'},{'7500'},{'9999'}];
Ts=[0.01,0.025,0.05,0.075,0.10,0.15,0.20,0.30,0.40,0.50,0.75,1.0,1.5,2.0,3.0,4.0,5.0,7.5,10];
if T == 0
    T = 0.01;
end
period=Ts==T;
if sum(period)>0
    [acc,~]=raeng_getpsa([directory,stemcoeff,char(periods(period)),num2str(branch,'%1i'),'.txt'],Mw,Rjb);
else
    error('No coefficients available for the desired period')
end
