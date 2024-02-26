function p = plotKaplanMeier(PFS1_olaparib, PFS1_cens_olaparib, PFS1, PFS1_cens, data_Placebo, data_Olaparib,range,Nr)
%% --  plot the Kaplan-Meier estimator from SOLO-1 clinical trial 
% INPUTS - PFS1_Olaparib - data (Olaparib arm)
%        - PFS1_Placebo - data (Placebo arm)
%        - data_Placebo - results from simulatioms (Placebo arm)
%        - data_Olaparib - results from simulations (Olaparib arm)
%        - range - the duration of follow-up to display
%        - Nr - which PFS has to be created 1st or 2nd?
% OUTPUT - p - figure with Kaplan-Meier plot
%% --
p=figure('Position', [465,424,775,554]);
[F_model_PFS, X_model_PFS] = ecdf(PFS1, 'Censoring', PFS1_cens,'function', 'survivor');
[F_model_PFS, id]= unique(F_model_PFS);
X_model_PFS = X_model_PFS(id);
[X_model_PFS, id]= unique(X_model_PFS);
F_model_PFS = F_model_PFS(id);
F_model_PFS = [1; F_model_PFS];
X_model_PFS = [0; X_model_PFS];
if Nr == 1
model_placebo=interp1(X_model_PFS,F_model_PFS,[5,10,15,20,25,30,35,40]);
data_placebo = interp1(data_Placebo(1:10:end,1), data_Placebo(1:10:end,2),[5,10,15,20,25,30,35,40]);
end

if Nr == 2
model_placebo=interp1(X_model_PFS,F_model_PFS,2.5:2.5:20);
data_placebo = interp1(data_Placebo(:,1), data_Placebo(:,2),2.5:2.5:20);
end

RMSE_Placebo=sqrt(mean((model_placebo-data_placebo).^2));
stairs(X_model_PFS,F_model_PFS,'color','b','LineWidth',4)
hold on

[F_model_PFS,X_model_PFS] = ecdf(PFS1_olaparib, 'Censoring', PFS1_cens_olaparib,'function', 'survivor');
[F_model_PFS, id]= unique(F_model_PFS);
X_model_PFS = X_model_PFS(id);
[X_model_PFS, id]= unique(X_model_PFS);
F_model_PFS = F_model_PFS(id);
F_model_PFS = [1; F_model_PFS];
X_model_PFS = [0; X_model_PFS];

stairs(X_model_PFS,F_model_PFS,'color','r','LineWidth',4)

if Nr ==1
    model=interp1(X_model_PFS,F_model_PFS,[5,10,15,20,25,30,35,40]);
    data = interp1(data_Olaparib(1:10:end,1), data_Olaparib(1:10:end,2),[5,10,15,20,25,30,35,40]);
    RMSE_Olaparib=sqrt(mean((model-data).^2));
end

if Nr ==2
    model=interp1(X_model_PFS,F_model_PFS,2.5:2.5:20);
    data = interp1(data_Olaparib(:,1), data_Olaparib(:,2), 2.5:2.5:20);
    RMSE_Olaparib=sqrt(mean((model-data).^2));
end

if Nr == 1
    stairs(data_Placebo(1:25:end,1), data_Placebo(1:25:end,2),'-', 'LineWidth',2, 'color', 'b'  )
    stairs(data_Olaparib(1:25:end,1), data_Olaparib(1:25:end,2),'-', 'LineWidth',2, 'color', 'r' )
end

if Nr == 2
    stairs(data_Placebo(1:3:end,1), data_Placebo(1:3:end,2),'-', 'LineWidth',2, 'color', 'b'  )
    stairs(data_Olaparib(:,1), data_Olaparib(:,2),'-', 'LineWidth',2, 'color', 'r' )
end

    if Nr==1
        cnt='1st ';
        text(35,.3,sprintf("RMSE = %.2f",RMSE_Placebo),'FontSize',18)
        text(35,.65,sprintf("RMSE = %.2f",RMSE_Olaparib),'FontSize',18)
    end

   if Nr==2
        cnt='2nd ';
        text(15,.225,sprintf("RMSE = %.2f",RMSE_Olaparib),'FontSize',18)
        text(15,.5,sprintf("RMSE = %.2f",RMSE_Placebo),'FontSize',18)
    end

    set(gca,'FontSize',22)
    xlim([0 range])
    xlabel('Time from randomization [months]')
    ylabel('Fraction of patients')
    title([cnt 'Progression-free survival'])
    legend('The model with placebo','The model with olaparib','The data for placebo','The data for olaparib') 
end