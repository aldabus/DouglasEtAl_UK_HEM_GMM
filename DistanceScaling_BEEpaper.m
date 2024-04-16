function DistanceScaling_BEEpaper()
%% Input Parameters

numberbranch = 3;
Twanted = [0.01,0.20,1.0];
periods = {'PGA','PSA0.2s','PSA1.0s'};
nT = length(Twanted);
Mw=[4.5,5.5,6.5];
nM=length(Mw);
Rjb=logspace(log10(1),log10(300),30); %Rjb
nR=length(Rjb);

%% PSA calculations
figure(1)
set(figure(1),'Units','centimeters','PaperSize',[16 16],'PaperPosition',[1 1 16 16]);
for ti = 1:nT
    subplot_tight(2,2,ti,[0.09,0.11])
    for mi = 1:nM
        for ri = 1:nR
            for bi = 1:numberbranch
               PSA(mi,ri,ti,bi) = raeng_backbone_model(Mw(mi),Rjb(ri),Twanted(ti),bi,numberbranch,'reweighted')*100;
            end
            PSA_f(mi,ri,ti) = PSA(mi,ri,ti,1)*0.185 + PSA(mi,ri,ti,2)*0.63 + PSA(mi,ri,ti,3)*0.185;
        end
    end

    loglog(Rjb,PSA_f(2,:,ti),'-','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
    hold on
    loglog(Rjb,PSA_f(1,:,ti),'--','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
    loglog(Rjb,PSA_f(3,:,ti),':','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
    box off

    xlabel('R_{JB} (km)','fontsize',12)
    set(gca,'xtick',[1,3,10,30,100,300],'fontsize',10)
    set(gca,'xticklabel',{'1','3','10','30','100','300'},'fontsize',10)
 
    ylabel(strcat(periods(ti),' (cm/s^2)'),'fontsize',12);
    if Twanted(ti) == 1
        axis([1 300 1E-2 1e3])
        set(gca,'ytick',[1e-2,1e-1,1,10,1e2,1e3])
    else
        axis([1 300 1E-1 1e3])
        set(gca,'ytick',[1e-2,1e-1,1,10,1e2,1e3])
    end

end
       