
clear variables
model = 5;
weightopt = {'original','reweighted'};
% T =0.025;

if model == 3
    directory=strcat(cd,'\FinalCoefficients\Coefficients-Rjb\3BranchModel\');
elseif model == 5
    directory=strcat(cd,'\FinalCoefficients\Coefficients-Rjb\5BranchModel\');
end

periods=[{'0010'},{'0025'},{'0050'},{'0075'},{'0100'},{'0150'},{'0200'},{'0300'},{'0400'},{'0500'},{'0750'},...
    {'1000'},{'1500'},{'2000'},{'3000'},{'4000'},{'5000'},{'7500'},{'9999'}];
Ts=[0.01,0.025,0.05,0.075,0.10,0.15,0.20,0.30,0.40,0.50,0.75,1.0,1.5,2.0,3.0,4.0,5.0,7.5,10];
ri = 0;
% period=Ts==T;


% fid1=fopen(fout,"w");

for wi = 1:2
    stemcoeff=['coeffukboth_',num2str(model,'%1i'),'branches_',char(weightopt(wi)),'_'];
    for Ti = 1:length(Ts)
        for bri = 1:model
            branch = bri;
            ri = ri + 1;
            disp(strcat(num2str(branch),'-',num2str(ri)))
            cinfile = [directory,stemcoeff,char(periods(Ti)),num2str(branch,'%1i'),'.txt'];
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
            %     case {1,4}
            %         nc=5;
            %     case {2,5,7,8}
            %         nc=4;
            %     case {3}
            %         nc=6;
            %     case {6}
            %         nc=3;
            %     case {9}
            %         nc=7;
            %     case {10}
            % 
                case {11}
                    nc=10;
            %     case {12}
            %         nc=9;
            end
            % switch runpar(3)
            %     case {1,2}
            %         nc=nc+2;
            % end
            switch runpar(2)
                case {1}
                    nsd=1;
                % case{2,3,4}
                %     nsd=2;
                % case {5}
                %     nsd=3;
            end
            
            data=fscanf(fid,'%f',[3*nc+nsd+6 inf]);
            for i = 1:numel(data)
                if i == 1
                    dataout(ri,1:4) = {[num2str(model),'-branches'],char(weightopt(wi)),branch,data(i)};
                elseif i == 2
                    if data(i) == 9999
                        dataout(ri,3+i) = {10};
                    else
                        dataout(ri,3+i) = {data(i)/1000};
                    end
                else
                    dataout(ri,3+i) = {data(i)};
                end
            end
            fclose(fid);
        end
    end
end

if model == 3
    DATDT24_Coefficients3b = array2table(dataout);
    DATDT24_Coefficients3b.Properties.VariableNames=['Model','Weighting Option','Branch','Damping (%)','Period (s)',heading(3:end)'];
    DATDT24_Coefficients3b.Properties.VariableUnits=["","","","%","s",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''];
    save("DATDT24_Coefficients.mat","DATDT24_Coefficients3b")
elseif model == 5
    DATDT24_Coefficients5b = array2table(dataout);
    DATDT24_Coefficients5b.Properties.VariableNames=['Model','Weighting Option','Branch','Damping (%)','Period (s)',heading(3:end)'];
    DATDT24_Coefficients5b.Properties.VariableUnits=["","","","%","s",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''];
    save('DATDT24_Coefficients.mat','DATDT24_Coefficients5b','-append')
elseif model == 216
    DATDT24_Coefficients216b = array2table(dataout);
    DATDT24_Coefficients216b.Properties.VariableNames=['Model','Weighting Option','Branch','Damping (%)','Period (s)',heading(3:end)'];
    DATDT24_Coefficients216b.Properties.VariableUnits=["","","","%","s",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''];
    save('DATDT24_Coefficients.mat','DATDT24_Coefficients216b','-append')
end



