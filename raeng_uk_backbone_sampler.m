function raeng_uk_backbone_sampler()

format long

Rtype = 'Rjb';
weight_type = 'reweighted';
model = 3;
tic
switch weight_type
    case 'original'
        ztor=[0.6,0.4];
        dsweights=[0.185,0.63,0.185]; % kappa
        gsweights=[0.25,0.25,0.5]; % note that the bump is the third branch; geom spread
        qweights=[0.185,0.63,0.185]; % q
        sdweights=[0.185,0.63,0.185]; % stress drop
    case 'reweighted'
        updatedweights=[ 0.000139163
            0.000853416
            0.000443567
            0.000209342
            0.001209361
            0.000577485
            0.001633584
            0.007420652
            0.002519703
            0.000199076
            0.001297345
            0.000753248
            0.000312874
            0.00192836
            0.001036076
            0.002931361
            0.014438385
            0.005681987
            6.37175E-05
            0.000438496
            0.000280508
            0.000104456
            0.000681898
            0.000405515
            0.001166928
            0.00616119
            0.002733495
            0.00189544
            0.008791831
            0.002982652
            0.00248339
            0.010816395
            0.0033578
            0.010906751
            0.036869926
            0.008007715
            0.003460976
            0.017690297
            0.007144165
            0.004754471
            0.022914248
            0.008531961
            0.025437532
            0.096781996
            0.02600584
            0.001372618
            0.007616259
            0.003529998
            0.001973603
            0.010356872
            0.004446103
            0.012766591
            0.053536702
            0.016894753
            0.000735095
            0.003055495
            0.000876272
            0.00091666
            0.003572729
            0.000935894
            0.003276542
            0.00985545
            0.001792945
            0.0014808
            0.006887614
            0.002416664
            0.001939271
            0.008494135
            0.002743525
            0.008501108
            0.029243852
            0.006773033
            0.000639494
            0.003265124
            0.001336599
            0.000877874
            0.004233858
            0.001602847
            0.004681405
            0.017952326
            0.004965314
            9.27755E-05
            0.000568944
            0.000295711
            0.000139561
            0.000806241
            0.00038499
            0.001089056
            0.004947101
            0.001679802
            0.000132717
            0.000864897
            0.000502165
            0.000208583
            0.001285573
            0.000690717
            0.001954241
            0.00962559
            0.003787991
            4.24783E-05
            0.000292331
            0.000187005
            6.96372E-05
            0.000454599
            0.000270344
            0.000777952
            0.00410746
            0.00182233
            0.001263626
            0.00586122
            0.001988435
            0.001655594
            0.00721093
            0.002238533
            0.007271167
            0.024579951
            0.005338477
            0.002307317
            0.011793531
            0.004762777
            0.003169647
            0.015276165
            0.005687974
            0.016958355
            0.064521331
            0.017337227
            0.000915079
            0.005077506
            0.002353332
            0.001315736
            0.006904581
            0.002964068
            0.008511061
            0.035691135
            0.011263169
            0.000490064
            0.002036997
            0.000584181
            0.000611107
            0.00238182
            0.000623929
            0.002184362
            0.0065703
            0.001195296
            0.0009872
            0.004591743
            0.001611109
            0.001292847
            0.005662756
            0.001829016
            0.005667405
            0.019495901
            0.004515355
            0.000426329
            0.002176749
            0.000891066
            0.000585249
            0.002822572
            0.001068564
            0.003120936
            0.011968217
            0.003310209
            ];
end

stress=[1,2,3];

Mw=3.00:0.25:7.75;
df=[0,2,5,10,20,30,40,50,70,100,130,200,300,500,700,1000];
nm=length(Mw);
nd=length(df);
periods=[
    {'0010'},...
    {'0025'},...
    {'0050'},{'0075'},{'0100'},{'0150'},{'0200'},...
    {'0300'},{'0400'},{'0500'},{'0750'},{'1000'},{'1500'},{'2000'},...
    {'3000'},{'4000'},{'5000'},{'7500'},{'9999'}
    ];
nT=length(periods);

switch model
    case 3
        % three-branch version
        percentiles=[0.05, 0.5, 0.95] * 100;
    case 5
        % five-branch version
        percentiles=[0.034893, 0.211702, 0.5, 0.788298, 0.965107] * 100;
end

y=zeros(nm,nd,length(percentiles));
for t=1:nT
    ms=zeros(nm,nd);
    dfs=ms;
    for i=1:nm
        for j=1:nd
            count=1;
            totalcount=1;
            % Error in original calculations where on ZTor 1 was used
            for z=1:2 
                stem=[
                    'C:/GitHub/DouglasEtAl_UK_HEM_GMM\CHEEP output files/ZTOR',...
                    num2str(z,'%1i'),'/cyz',...
                    num2str(z,'%1i'),char(periods(t))
                    ];
                if i<10
                    infile=[stem,'00',num2str(i)];
                else
                    infile=[stem,'0',num2str(i)];
                end
                if j<10
                    infile=[infile,'00',num2str(j)];
                else
                    infile=[infile,'0',num2str(j)];
                end
                infile=[infile,'.dat'];
                % disp(infile)

                % Reading in the filenames
                % rrup, ~, stress drop, geom spreading, path attn (Q),
                % ~, site diminution (kappa?)
                [~,~,~,~,rrupt(:,z),~,~,~,~,~,~,~,~,~,~,stbran,gsbran,qbran,~,sdbran,~,yt,~]=...
                    textread( ...
                    infile, ...
                    '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', ...
                    'headerlines',2 ...
                    );
                for sd=1:3 % stress drop
                    for ds=1:3 % kappa
                        for gs=1:3 % Geometrical spreading
                            for q=1:3 % Q factor
                                values=yt(stbran==stress(sd) & sdbran==ds & gsbran==gs & qbran==q);
                                if ~isempty(values)
                                    storedvalues(count)=log(mean(values));
                                    switch weight_type
                                        case 'original'
                                            weights(count)=ztor(z)*sdweights(sd)...
                                                *dsweights(ds)*gsweights(gs)*qweights(q);
                                        case 'reweighted'
                                            weights(count)=updatedweights(totalcount);
                                    end
                                    count=count+1;
                                end
                                totalcount=totalcount+1;
                            end
                        end
                    end
                end
            end
            y(i,j,:)=exp(wprctile(storedvalues,percentiles,weights,4));
            ms(i,j)=Mw(i);
            switch Rtype
                case 'Rjb'
                    dfs(i,j)=df(j);  % if rjb
                case 'Rrup'
                    % dfs(i,j) = 0.6 * rrupt(1,1) + 0.4 * rrupt(1,2); % if rrup
                    dfs(i,j) = rrupt(1,1);
            end
        end
    end

    switch model
        case 3 % 3 branches
            T=table(reshape(ms,[nm*nd,1]),reshape(dfs,[nm*nd,1]),reshape(y(:,:,1), ...
               [nm*nd,1]),reshape(y(:,:,2),[nm*nd,1]),reshape(y(:,:,3),[nm*nd,1]));
            if strcmp(Rtype,'Rjb') && strcmp(weight_type,'original')
                writetable( ...
                    T, ...
                    ['original3bothrjb',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            elseif strcmp(Rtype,'Rjb') && strcmp(weight_type,'reweighted')
                writetable( ...
                    T, ...
                    ['reweighted3bothrjb',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            elseif strcmp(Rtype,'Rrup') && strcmp(weight_type,'original')
                writetable( ...
                    T, ...
                    ['original3bothrrup',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            elseif strcmp(Rtype,'Rrup') && strcmp(weight_type,'reweighted')
                writetable( ...
                    T, ...
                    ['reweighted3bothrrup',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            end
        case 5 % 5 branches
            T=table(reshape(ms,[nm*nd,1]),reshape(dfs,[nm*nd,1]),reshape(y(:,:,1), ...
                [nm*nd,1]),reshape(y(:,:,2),[nm*nd,1]),reshape(y(:,:,3),[nm*nd,1]),...
                reshape(y(:,:,4),[nm*nd,1]),reshape(y(:,:,5),[nm*nd,1]));
            if strcmp(Rtype,'Rjb') && strcmp(weight_type,'original')
                writetable( ...
                    T, ...
                    ['original5bothrjb',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            elseif strcmp(Rtype,'Rjb') && strcmp(weight_type,'reweighted')
                writetable( ...
                    T, ...
                    ['reweighted5bothrjb',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            elseif strcmp(Rtype,'Rrup') && strcmp(weight_type,'original')
                writetable( ...
                    T, ...
                    ['original5bothrrup',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            elseif strcmp(Rtype,'Rrup') && strcmp(weight_type,'reweighted')
                writetable( ...
                    T, ...
                    ['reweighted5bothrrup',char(periods(t)),'.txt'], ...
                    'Delimiter', ...
                    ' ', ...
                    'WriteRowNames', ...
                    true)
            end
    end

    
end
toc

% iM=find(Mw==M)
% loglog(df,squeeze(y(iM,:,1))*100,'k:')
% hold on
% loglog(df,squeeze(y(iM,:,2))*100,'k--')
% loglog(df,squeeze(y(iM,:,3))*100,'k-')
% loglog(df,squeeze(y(iM,:,4))*100,'k--')
% loglog(df,squeeze(y(iM,:,5))*100,'k:')
%
% set(gca,'xtick',[1,2,5,10,20,50,100,200,300]);
% set(gca,'yminortick','on')
% set(gca,'ytick',[1E-4,2E-4,5E-4,1E-3,2E-3,5E-3,1E-2,2E-2,5E-2,1E-1,2E-1,5E-1,1,2,5,10,20,50,100,200,500,1000,2000]);
% set(gca,'xlim',[1 300])
% %set(gca,'ylim',[1,2000])
% xlabel('R_{JB} (km)')
% ylabel('(cm/s^2)')
% %title(['PGA ','M_w',num2str(M)])
% box off
