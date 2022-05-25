%% code to generate figure 2

%% for paper "Dissolved organic phosphorus concentrations in the surface ocean controlled by both phosphate and iron stress"
%% Zhou Liang
%% May 22 2022

clear all;
% read figure 2 data
data = readtable('data.csv');



%% plot upper 50 m DOP stock vs iron stress and [chl-a] for P06 section
% slice P06 data
P06 = data(strcmp(data.section,'P06'),:);
% data point not in Surface Convegence Zone and wiht nFLH>=0.003
P06nocov = P06(~(P06.LONGITUDE<-98 & P06.LONGITUDE>-133) & P06.nFLH>=0.003,:);

% data point in Surface Convergence Zone and wiht nFLH>=0.003
P06cov = P06(P06.LONGITUDE<-98 & P06.LONGITUDE>-133 & P06.nFLH>=0.003,:);

% data point with nFLH<0.003, only found in Surface Convergence zone
P06flh = P06(P06.nFLH<0.003,:);
% Type II linear model for DOP stock vs iron stress
[c,bintr,bintjm,p] = gmregress(P06.ironStress*100,P06.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept


% make figure P06 DOP vs iron stress
x = [1.2:0.1:2.2]
hold on 
plot(P06nocov.ironStress*100, P06nocov.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(P06cov.ironStress*100, P06cov.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'r','MarkerSize',12)
plot(P06flh.ironStress*100, P06flh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'r','MarkerSize',12)

xlabel('NPQ-corrected \phi_{sat} (%)  ')
ylabel('DOP stock (mmol m^{-2})')
xlim([1.2 2.2])
plot(x,m*x+b,'-k','LineWidth',2)

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off

% linear model for DOP stock vs [chl-a]
[c,bintr,bintjm,p] = gmregress(P06.ChlA,P06.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs [chl-a]
x = [0.05:0.01:0.4];
hold on
plot(P06nocov.ChlA, P06nocov.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(P06cov.ChlA, P06cov.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'r','MarkerSize',12)
plot(P06flh.ChlA, P06flh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'r','MarkerSize',12)


xlabel('[Chl-{\it a}] (mg m^{-3})')
ylabel('DOP stock (mmol m^{-2})')

xlim([0.05 0.4])
ylim([0 20])
plot(x,m*x+b,'-k','LineWidth',2)

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off


%% plot upper 50 m DOP stock vs iron stress and [chl-a] for  section P18
% slice P18 data
P18 = data(strcmp(data.section,'P18'),:);

% data point with nFLH>= 0.03
P18noflh = P18(P18.nFLH>=0.003,:);
% data point with nFLH<0.03
P18flh = P18(P18.nFLH<0.003,:);

% linear model for DOP stock vs iron stress
[c,bintr,bintjm,p] = gmregress(P18.ironStress*100,P18.upper50mDOPstock)

b = c(1) % slope
m = c(2) % intercept


% plot DOP stock vs iron stress
x = [0.5:0.1:2.5];
hold on 
plot(P18noflh.ironStress*100, P18noflh.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(P18flh.ironStress*100, P18flh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)


plot(x,m*x+b,'-k','LineWidth',2)

xlabel('NPQ-corrected \phi_{sat} (%)  ')
ylabel('DOP stock (mmol m^{-2})')

xlim([0.5 2.5])
ylim([0 25])

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off

% linear model for DOP stock vs [chl-a]
[c,bintr,bintjm,p] = gmregress(P18.ChlA,P18.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept



% plot DOP stock vs [chl-a]
x = [0:0.01:0.2];
hold on
plot(P18noflh.ChlA, P18noflh.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(P18flh.ChlA, P18flh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)

plot(x,m*x+b,'-k','LineWidth',2)


xlabel('[Chl-{\it a}] (mg m^{-3})')
ylabel('DOP stock (mmol m^{-2})')

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off


%% plot upper 50 m DOP stock vs iron stress and [chl-a] for  section AMT17,AMT14 and 36N
% slice AMT17, AMT17,AMT14 and 36N data
AMT17 = data(strcmp(data.section,'AMT17')|strcmp(data.section,'AMT14')|strcmp(data.section,'36N'),:);
% data point in the south atlantic, not in the convergence zone , and  nFLH>0.003
AMT17S = AMT17(AMT17.LATITUDE<0 & ~(AMT17.LATITUDE<0 & AMT17.LONGITUDE<-2 & AMT17.LONGITUDE>-22) & AMT17.nFLH>=0.003 ,:);
% data point in the North atlantic, not in the convergence zone , and nFLH>0.003
AMT17N = AMT17(AMT17.LATITUDE>=0 & ~(AMT17.LATITUDE<0 & AMT17.LONGITUDE<-2 & AMT17.LONGITUDE>-22) & AMT17.nFLH>=0.003,:);
% data point in the South Atlantic Cnnvergence zone, and nFLH>0.003
AMT17cov = AMT17(AMT17.LATITUDE<0 & AMT17.LONGITUDE<-2 & AMT17.LONGITUDE>-22 & AMT17.nFLH>=0.003,:);
% data point in the North Atlantic, and nFLH<0.003
AMT17flhN = AMT17(AMT17.nFLH<0.003 & AMT17.LATITUDE>0,:);
% data point in the South Atlantic Cnnvergence zone, and nFLH<0.003
AMT17flhcov = AMT17(AMT17.LATITUDE<0 & AMT17.LONGITUDE<-2 & AMT17.LONGITUDE>-22 & AMT17.nFLH<0.003,:);
% data point in the South Atlantic, not in the Cnnvergence zone, and nFLH < 0.003
AMT17flhS = AMT17(AMT17.LATITUDE<0 & ~(AMT17.LATITUDE<0 & AMT17.LONGITUDE<-2 & AMT17.LONGITUDE>-22) & AMT17.nFLH<0.003 ,:);

% linear model for DOP stock vs iron stress
[c,bintr,bintjm,p] = gmregress(AMT17.ironStress*100,AMT17.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs iron stress
x = [0.8:0.1:2];
hold on
plot(AMT17N.ironStress*100, AMT17N.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'none','MarkerSize',12)
%errorbar(data(strcmp(data.section, section(i)),:).N_P_var_fill,data(strcmp(data.section, section(i)),:).DOPstock,data(strcmp(data.section, section(i)),:).DOPstock_err,'o','color',colorstring(i,:),'MarkerFaceColor', colorstring(i,:),'MarkerSize',6);
%hline = refline(m,b);
xlabel('NPQ-corrected \phi_{sat} (%)  ')
ylabel('DOP stock (mmol m^{-2})')
%set(hline,'color','k');
xlim([0.8 2.0])
ylim([0 20])
plot(AMT17S.ironStress*100, AMT17S.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(AMT17cov.ironStress*100, AMT17cov.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'r','MarkerSize',12)
plot(AMT17flhcov.ironStress*100, AMT17flhcov.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'r','MarkerSize',12)
plot(AMT17flhN.ironStress*100, AMT17flhN.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'none','MarkerSize',12)
plot(AMT17flhS.ironStress*100, AMT17flhS.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)

plot(x,m*x+b,'-k','LineWidth',2)
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off

% linear model for DOP stock vs [chl-a]
[c,bintr,bintjm,p] = gmregress(AMT17.ChlA,AMT17.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs [chl-a]
hold on
plot(AMT17N.ChlA, AMT17N.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'none','MarkerSize',12)
plot(AMT17S.ChlA, AMT17S.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(AMT17cov.ChlA, AMT17cov.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'r','MarkerSize',12)
plot(AMT17flhcov.ChlA, AMT17flhcov.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'r','MarkerSize',12)
plot(AMT17flhN.ChlA, AMT17flhN.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'none','MarkerSize',12)
plot(AMT17flhS.ChlA, AMT17flhS.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)


hline = refline(m,b);
xlabel('[Chl-{\it a}] (mg m^{-3})')
ylabel('DOP stock (mmol m^{-2})')
set(hline,'color','k','Linewidth',2);
ylim([0 20])

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off


%% plot upper 50 m DOP stock vs iron stress and [chl-a] for  section KH12-3
% slice KH12-3 data
KH123 = data(strcmp(data.section,'KH-12-3'),:);

% nFLH >=0.003 
KH123noflh = KH123(KH123.nFLH>=0.003,:);

% nFLH < 0.003
KH123flh = KH123(KH123.nFLH<0.003,:);


% linear model for DOP stock vs iron stress
[c,bintr,bintjm,p] = gmregress(KH123.ironStress*100,KH123.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs iron stress
x = [1:0.1:2.5];
hold on
plot(KH123noflh.ironStress*100, KH123noflh.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(KH123flh.ironStress*100, KH123flh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)

xlabel('NPQ-corrected \phi_{sat} (%)  ')
ylabel('DOP stock (mmol m^{-2})')
plot(x,m*x+b,'-k','LineWidth',2)

ylim([4 8])
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off

% linear model for DOP stock vs [chl-a]
[c,bintr,bintjm,p] = gmregress(KH123.ChlA,KH123.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs [chl-a]
x = [0.02:0.01:0.1]
hold on 
plot(KH123noflh.ChlA, KH123noflh.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(KH123flh.ChlA, KH123flh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)

xlabel('[Chl-{\it a}] (mg m^{-3})')
ylabel('DOP stock (mmol m^{-2})')

plot(x,m*x+b,'-k','LineWidth',2)

ylim([4 8])
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off



%% plot upper 50 m DOP stock vs iron stress and [chl-a] for  section BIOSOPE
% slice BIOSOPE data without coastal station where PO4 > 1.5 uM
BIOSOPE = data(strcmp(data.section,'BIOSOPE')& ~strcmp(data.comment,'coastal'),:);
% nFLH >= 0.003
BIOSOPEnoflh = BIOSOPE(BIOSOPE.nFLH>=0.003,:);
% nFLH <0.003
BIOSOPEflh = BIOSOPE(BIOSOPE.nFLH<0.003,:);
% linear model for DOP stock vs iron stress
[c,bintr,bintjm,p] = gmregress(BIOSOPE.ironStress*100,BIOSOPE.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs iron stress
x = [1:0.1:2.2]
hold on
plot(BIOSOPEnoflh.ironStress*100, BIOSOPEnoflh.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(BIOSOPEflh.ironStress*100, BIOSOPEflh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)

hline = refline(m,b);
xlabel('NPQ-corrected \phi_{sat} (%)  ')
ylabel('DOP stock (mmol m^{-2})')
set(hline,'color','k','Linewidth',2);
ylim([5 25])
plot(x,m*x+b,'-k','LineWidth',2)

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off

% linear model for DOP stock vs [chl-a]
[c,bintr,bintjm,p] = gmregress(BIOSOPE.ChlA,BIOSOPE.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept
hold on 
% plot graph
plot(BIOSOPEnoflh.ChlA, BIOSOPEnoflh.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
plot(BIOSOPEflh.ChlA, BIOSOPEflh.upper50mDOPstock,'^','color','k','MarkerFaceColor', 'k','MarkerSize',12)
%errorbar(data(strcmp(data.section, section(i)),:).N_P_var_fill,data(strcmp(data.section, section(i)),:).DOPstock,data(strcmp(data.section, section(i)),:).DOPstock_err,'o','color',colorstring(i,:),'MarkerFaceColor', colorstring(i,:),'MarkerSize',6);
hline = refline(m,b);
xlabel('[Chl-{\it a}] (mg m^{-3})')
ylabel('DOP stock (mmol m^{-2})')
set(hline,'color','k','Linewidth',2);
xlim([0 2])
ylim([5 25])
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off


%% plot upper 50 m DOP stock vs iron stress and [chl-a] for  section GOM2019
% slice GOM2019 data
GOM2019 = data(strcmp(data.section,'GOM2019'),:);
% all data point with nFLH > 0.003


% linear model for DOP stock vs iron stress
[c,bintr,bintjm,p] = gmregress(GOM2019.ironStress*100,GOM2019.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs iron stress
x = [0.4:0.1:1.2];
hold on
plot(GOM2019.ironStress*100, GOM2019.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
hline = refline(m,b);
xlabel('NPQ-corrected \phi_{sat} (%)  ')
ylabel('DOP stock (mmol m^{-2})')
set(hline,'color','k','Linewidth',2);

plot(x,m*x+b,'-k','LineWidth',2)

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off

% linear model for DOP stock vs [chl-a]
[c,bintr,bintjm,p] = gmregress(GOM2019.ChlA,GOM2019.upper50mDOPstock)
b = c(1) % slope
m = c(2) % intercept

% plot DOP stock vs [chl-a]
plot(GOM2019.ChlA, GOM2019.upper50mDOPstock,'o','color','k','MarkerFaceColor', 'k','MarkerSize',12)
hline = refline(m,b);
xlabel('[Chl-{\it a}] (mg m^{-3})')
ylabel('DOP stock (mmol m^{-2})')
set(hline,'color','k','Linewidth',2);

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',24,'FontWeight','Bold', 'LineWidth', 2);
box on
grid off


