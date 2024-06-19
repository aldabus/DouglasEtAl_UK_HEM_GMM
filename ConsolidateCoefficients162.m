
clear variables
model = 162;
weightopt = {'original','reweighted'};
wi = 1; %1 for 'original', 2 for 'reweighted'

directory=strcat(cd,'\FinalCoefficients\Coefficients-Rjb\162BranchModel\');

periods=[{'0010'},{'0025'},{'0050'},{'0075'},{'0100'},{'0150'},{'0200'},{'0300'},{'0400'},{'0500'},{'0750'},...
    {'1000'},{'1500'},{'2000'},{'3000'},{'4000'},{'5000'},{'7500'},{'9999'}];
Ts=[0.01,0.025,0.05,0.075,0.10,0.15,0.20,0.30,0.40,0.50,0.75,1.0,1.5,2.0,3.0,4.0,5.0,7.5,10];
ri = 0;

% for wi = 1:2
    for Ti = 1:length(Ts)
        branch = 0;
        for zi = 1:2 %ZTOR
            for sti = 1:3 %Stress drop
                for ki = 1:3 %kappa
                    for gi = 1:3 %geometric mean
                        for qi = 1:3 %Q
                            branch = branch + 1;
                            ri = ri + 1;
                            stemcoeff=['coeffukz',num2str(zi,'%1i'),char(periods(Ti)),num2str(sti,'%1i'),...
                                num2str(ki,'%1i'),num2str(gi,'%1i'),num2str(qi,'%1i')];
                            cinfile = [directory,stemcoeff,'.txt'];
                            disp(strcat(num2str(ri),'-',num2str(branch),'-',stemcoeff))
                            % Reading in the coefficients
                            fid = fopen(cinfile,'rt');
                            runpar = fscanf(fid,'%f %f %f %f',[4 inf]);
                            % heading = ' ';
                            hi = 1;
                            cchar=' ';
                            while cchar ~= 'c'
                                heading(hi,:) = {fscanf(fid,'%s',[1,1])};
                                cchar = char(heading(hi,:));
                                hi = hi + 1;
                            end

                            switch runpar(1)
                                case {11}
                                    nc=10;
                            end
                            switch runpar(2)
                                case {1}
                                    nsd=1;
                            end
                
                            data=fscanf(fid,'%f',[3*nc+nsd+6 inf]);
                            for i = 1:numel(data)
                                if i == 1
                                    dataout(ri,1:4) = {'162-branches',char(weightopt(wi)),branch,data(i)};
                                elseif i == 2
                                    if data(i) == 9.999
                                        dataout(ri,3+i) = {10};
                                    else
                                        dataout(ri,3+i) = {data(i)};
                                    end
                                else
                                    dataout(ri,3+i) = {data(i)};
                                end
                            end
                            fclose(fid);
                        end
                    end
                end
            end
        end
    end
% end

DATDT24_Coefficients162b = array2table(dataout);
DATDT24_Coefficients162b.Properties.VariableNames=['Model','Weighting Option','Branch','Damping (%)','Period (s)',heading(3:end)'];
DATDT24_Coefficients162b.Properties.VariableUnits=["","","","%","s",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''];
save(strcat(cd,'\FinalCoefficients\DATDT24_Coefficients.mat'),'DATDT24_Coefficients162b','-append')




