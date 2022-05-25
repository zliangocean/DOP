%% code to generate figure 1b

%% for paper "Dissolved organic phosphorus concentrations in the surface ocean controlled by both phosphate and iron stress"
%% Zhou Liang
%% May 22 2022

clear all;
% read data
data = readtable('data.csv');


% define 7 sections/cruises
section = {'Eastern North Pacific' 'Eastern South Pacific' 'Gulf of Mexico' 'South Atlantic' 'Western North Pacific' 'Western South Pacific' 'North Atlantic'}'

% define a diverging colorblind safe palette. https://colorbrewer2.org/#type=diverging&scheme=RdYlBu&n=7
colorstring =[ 215/255 48/255 39/255
    252/255   141/255   89/255
    254/255   224/255   144/255
    255/255   255/255   191/255
    224/255   243/255   248/255
    145/255   191/255   219/255
    69/255    117/255   180/255   
    
    ]
    
    

%% perform type II regression on P star vs upper 50 m DOP stock
[c,bintr,bintjm,p] = gmregress(data.PStar, data.upper50mDOPstock)

b = c(1) % intercept 
m = c(2) % slope
n = c(4) % sample size

%% calculate 95% confidence interval
%Find SSE and MSE
sse = nansum((data.upper50mDOPstock - (data.PStar*m+b)).^2);
mse = sse / (n - 2);
  
se = sqrt(mse) * sqrt(1 / n + (data.PStar - nanmean(data.PStar)).^2 / nansum((data.PStar - nanmean(data.PStar)).^2))

upper = data.PStar*m+b+1.97*se;
lower = data.PStar*m+b-1.97*se;

bond = [data.PStar,upper,lower];
bond = sort(bond,1);


%% make  figure 1a

hold on

for i = 1:length(section)
plot(data(strcmp(data.region, section(i)),:).PStar,data(strcmp(data.region, section(i)),:).upper50mDOPstock,'o','color',colorstring(i,:),'MarkerFaceColor', colorstring(i,:),'MarkerSize',9,'MarkerEdgeColor','k','LineWidth',0.25)
end


hline = refline(m,b);
plot(0.023,3,'bo','MarkerSize',12,'LineWidth',2)  % BATS point surface P*
plot(0.116,10,'ro','MarkerSize',12,'LineWidth',2) % ALOHA point surfaceP*

%plot(-0.03,3,'bo','MarkerSize',12,'LineWidth',2)  % BATS point 100 - 250 m P*
%plot(0.11,10,'ro','MarkerSize',12,'LineWidth',2) % ALOHA point 100 -250 m P*

plot(bond(:,1),bond(:,2),'--','color',[0, 0.4470, 0.7410])
plot(bond(:,1),bond(:,3),'--','color',[0, 0.4470, 0.7410])

xlabel('P* (µM)')
ylabel('upper 50 m DOP stock (mmol m^{-2})')
ylim([0 30])
set(hline,'color','k','Linewidth',2);
%% WOA2013 surface P*
legend(vertcat(section,'best fit line, y = 55.6x+1.01, R^{2} = 0.28,p<0.00000001,n = 202)','BATS','ALOHA'),'location','northwest');
%% in situ surface P*
%legend(vertcat(section,'best fit line, y = 43.8x+4.2, R^{2} = 0.29,p<0.00000001,n = 199)','BATS','ALOHA'),'location','northwest'); 
%% WOA 2013 100-250 m P*
%legend(vertcat(section,'best fit line, y = 24.3x+4.8, R^{2} = 0.45,p<0.00000001,n = 190)','BATS','ALOHA'),'location','northwest');

legend boxoff
set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);

box on
grid on
