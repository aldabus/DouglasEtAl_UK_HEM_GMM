function ResponseSpectra_BEEpaper()
%% Input Parameters
numberbranch = 3;
periods = {'PGA','PSA0.2s','PSA1.0s'};
Mw=[5,6.5];
nM=length(Mw);
Rjb=[30 100]; %Rjb
nR=length(Rjb);
T = [0.01,0.025,0.05,0.075,0.10,0.15,0.20,0.30,0.40,0.50,0.75,1.0,1.5,2.0,3.0,4.0,5.0,7.5,10];

%% PSA calculations
for ri = 1:nR
    for mi = 1:nM
        for ti = 1:length(T)
            for bi = 1:numberbranch
               % PSA_fall(ti,ri,mi,bi) = raeng_backbone_model(Mw(mi),Rjb(ri),T(ti),bi,numberbranch,'reweighted')*100;
               PSA_fall(ti,ri,mi,bi) = DATDT24(Mw(mi),Rjb(ri),0,T(ti),numberbranch,bi,'reweighted')*100;
            end
            PSA_f(ti,ri,mi) = PSA_fall(ti,ri,mi,1)*0.185 + PSA_fall(ti,ri,mi,2)*0.63 + PSA_fall(ti,ri,mi,3)*0.185;
        end
    end
end
    
figure(ti)
w = 0.15;
h = 0.11;
subplot_tight(2,2,1,[w,h])
semilogx(T,PSA_f(:,1,1),'-','LineWidth',1.5,'color',[0.3 0.3 0.3])
hold on
semilogx(T,PSA_fall(:,1,1,1),'--','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,1,1,2),'-','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,1,1,3),'-.','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
ylabel('PSA (cm/s^2)');
xlabel('Period (s)');
set(gca,'xtick',[0.01,0.1,1,10],'xticklabel',{'0.01','0.1','1','10'},'fontsize',13);
title(['M = ',num2str(Mw(1)),'; R_{JB} = ',num2str(Rjb(1))],'fontsize',9)
ax = gca;
ax.TitleHorizontalAlignment = 'left';
box off

subplot_tight(2,2,2,[w,h])
semilogx(T,PSA_f(:,2,1),'-','LineWidth',1.5,'color',[0.3 0.3 0.3])
hold on
semilogx(T,PSA_fall(:,2,1,1),'--','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,2,1,2),'-','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,2,1,3),'-.','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
ylabel('PSA (cm/s^2)');
xlabel('Period (s)');
set(gca,'xtick',[0.01,0.1,1,10],'xticklabel',{'0.01','0.1','1','10'},'fontsize',13);
title(['M = ',num2str(Mw(1)),'; R_{JB} = ',num2str(Rjb(2))],'fontsize',9)
ax = gca;
ax.TitleHorizontalAlignment = 'left';
box off

subplot_tight(2,2,3,[w,h])
semilogx(T,PSA_f(:,1,2),'-','LineWidth',1.5,'color',[0.3 0.3 0.3])
hold on
semilogx(T,PSA_fall(:,1,2,1),'--','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,1,2,2),'-','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,1,2,3),'-.','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
ylabel('PSA (cm/s^2)');
xlabel('Period (s)');
set(gca,'xtick',[0.01,0.1,1,10],'xticklabel',{'0.01','0.1','1','10'},'fontsize',13);
title(['M = ',num2str(Mw(2)),'; R_{JB} = ',num2str(Rjb(1))],'fontsize',9)
ax = gca;
ax.TitleHorizontalAlignment = 'left';
box off

subplot_tight(2,2,4,[w,h])
semilogx(T,PSA_f(:,2,2),'-','LineWidth',1.5,'color',[0.3 0.3 0.3])
hold on
semilogx(T,PSA_fall(:,2,2,1),'--','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,2,2,2),'-','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
semilogx(T,PSA_fall(:,2,2,3),'-.','LineWidth',1.5,'color',[0.85098 0.32549 0.098039])
ylabel('PSA (cm/s^2)');
xlabel('Period (s)');
set(gca,'xtick',[0.01,0.1,1,10],'xticklabel',{'0.01','0.1','1','10'},'fontsize',13);
title(['M = ',num2str(Mw(2)),'; R_{JB} = ',num2str(Rjb(2))],'fontsize',9)


       