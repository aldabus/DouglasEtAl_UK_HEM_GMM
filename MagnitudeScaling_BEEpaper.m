function MagnitudeScaling_BEEpaper()
%% Input Parameters
numberbranch = 3;
Twanted = [0.01,0.20,1.0];
periods = {'PGA','PSA0.2s','PSA1.0s'};
nT = length(Twanted);
Mw=4:0.5:7;
nM=length(Mw);
Rjb=[10 30 100]; %Rjb
nR=length(Rjb);

%% PSA calculations
figure(1)
set(figure(1),'Units','centimeters','PaperSize',[16 16],'PaperPosition',[0 0 16 16]);
for ti = 1:nT
    subplot_tight(2,2,ti,[0.09,0.11])
    for ri = 1:nR
        for mi = 1:nM
            for bi = 1:numberbranch
               % PSA(ri,mi,ti,bi) = raeng_backbone_model(Mw(mi),Rjb(ri),Twanted(ti),bi,numberbranch,'reweighted')*100;
               PSA(ri,mi,ti,bi) = DATDT24(Mw(mi),Rjb(ri),Twanted(ti),numberbranch,bi,'reweighted')*100;
            end
            PSA_f(ri,mi,ti) = PSA(ri,mi,ti,1)*0.185 + PSA(ri,mi,ti,2)*0.63 + PSA(ri,mi,ti,3)*0.185;
        end
    end

    semilogy(Mw,PSA_f(2,:,ti),'-','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
    hold on
    semilogy(Mw,PSA_f(1,:,ti),'--','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
    semilogy(Mw,PSA_f(3,:,ti),':','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
    box off

    xlabel('Magnitude (\bfM\rm)','fontsize',12)
    set(gca,'xtick',[4,5,6,7],'fontsize',10)
    set(gca,'xticklabel',{'4','5','6','7'},'fontsize',10)

 
    ylabel(strcat(periods(ti),' (cm/s^2)'),'fontsize',12);
    if Twanted(ti) == 1
        axis([4 7 1E-1 3e2])
        set(gca,'ytick',[1e-1,1,10,1e2,1e3])
    else
        axis([4 7 1 1e3])
        set(gca,'ytick',[1,10,1e2,1e3])
    end

end
