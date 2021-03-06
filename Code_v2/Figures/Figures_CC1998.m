global Regressions
%% Figures
clear
% Figure 7 in CC1998
load('PC_Claim_workspace')

Sample = 1:500;

figure;
subplot(2,1,1)
scatter(lnrtsim(Sample)*1e2,lndctsim(Sample)*1e2);title("Monthly Returns vs. consumption growth");
subplot(2,1,2)
scatter(alnrtsim_pf(Sample)*1e2,alndctsim_pf(Sample)*1e2);title("Annual Returns vs. consumption growth");
hold off
%saveas(gcf,string(['Figures/Figure_7_CC_1998_Calib_', num2str(calib),'_PD_', num2str(PD_Claim), '.eps']),'eps2c');


%%
load('PD_Claim_workspace');PD_ratio = output_lnpda;lnrPD = elnr_pf;BondYields_PD = lny_pf;
load('PC_Claim_workspace');PC_ratio = output_lnpca;lnrPC = elnr_pf;BondYields_PC = lny_pf;
%% PC/PD 
figure;
plot(S,exp(PC_ratio)/tsc,'LineWidth',1.5);% Annulized P/C-curve
hold on;
plot(S,exp(PD_ratio)/tsc,'LineWidth',1.5); % Annulized P/D-curve
ylabel('$P/C,\qquad P/D$','Interpreter','latex');
xlabel('Surplus Consumption ratio, $S$','Interpreter','latex');
xline(exp(Rec_s_bar),'--','$\bar{S}_{REC}$','Interpreter','latex');
xline(S_max,'--','$\bar{S}_{MAX}$','Interpreter','latex');
xline(0.02,'--','$\bar{S}_{2,REC}$','Interpreter','latex');
legend('PC-Ratio', 'PD-Ratio','Location','best')
hold off;
%saveas(gcf,string(['../Figures/PC_PD_Ratio']),'eps2c');
%% Stock Returns
figure;
plot(S,lnrPC *tsc*100,'LineWidth',1.5);
hold on
plot(S,lnrPD*tsc*100,'LineWidth',1.5);
plot(S,lnrf_pf*tsc*100,':k');
xline(exp(Rec_s_bar),'--','$\bar{S}_{REC}$','Interpreter','latex');
xline(S_max,'--','$\bar{S}_{MAX}$','Interpreter','latex');
xline(0.02,'--','$\bar{S}_{2,REC}$','Interpreter','latex');
ylabel('Expected Returns, annual percentage, $E_t ( r_{t+1} )$','Interpreter','latex');
xlabel('Surplus Consumption ratio, $S$','Interpreter','latex');
legend('Expected Return, Consumption Claim','Expected Return, Dividend Claim','Risk Free Rate','Interpreter','latex','Location','best');
%saveas(gcf,string(['../Figures/ErPCPD']),'eps2c');
%% Bond Returns
BondRets_PD = elnrcb_pf;
Maturities = [1,3,7,10,20]*12;
figure;
plot(S,BondRets_PD(:,Maturities),'LineWidth',1.5);
%hold on
%plot(S,BondYields_PD(:,Maturities)*100,'LineWidth',1.5);
xlabel('Surplus Consumption ratio, $S$','Interpreter','latex');
ylabel('Bond Returns','Interpreter','latex');
legend('1 year','3 years','7 years','10 years', '20 years','Interpreter','latex','Location','best');
%% Yield curves different S
Mats = string(S);
Chosen = [1,3,5,7,10];
Mats = Mats(Chosen);
figure;
% subplot(2,1,1)
plot(1:240, BondYields_PD(Chosen,:)*100,'LineWidth',1.5);%title('Dividend-Claim','interpreter','latex');
ylabel('Bond Yields,   Term-structure','Interpreter','latex');
yline(0,'--')
% subplot(2,1,2)
% title('PC')
% plot(1:240, BondYields_PC(Chosen,:)*100,'LineWidth',1.5);title('Dividend-Claim','interpreter','latex');
% xlabel('Maturity','Interpreter','latex');
% ylabel('Term Structure','Interpreter','latex');
leg = legend(Mats,'location','best');
title(leg,'Surplus Consumption Ratio')
