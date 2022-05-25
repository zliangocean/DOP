%% code to generate figure 1a

%% for paper "Dissolved organic phosphorus concentrations in the surface ocean controlled by both phosphate and iron stress"
%% Zhou Liang
%% May 22 2022

% read observed DOP data
data = readtable('data.csv');
% load predicted surface DOP concentration from three ML model.
load MLpredic.mat


% load OCIM2 global ocean grid
% more info about OCIM2 grid in 
load OCIM2/OCIM2_CTL_He.mat

M3d = output.M3d;
grid = output.grid;


% average three ML model surface DOP output
DOP_fit = M3d*0+nan;

DOP_fit(1:16380) = nanmean([boostedtree,SVM,Gaussian],2);

% refill land with NaN
DOP_fit(M3d(:) == 0) = NaN;

% shift longitude for easy visulization
data(data.LONGITUDE>30,:).LONGITUDE = data(data.LONGITUDE>30,:).LONGITUDE-360

% shift longitude of the OCIM grid for easy visulization
grid = output.grid;
DOP_fit_1 = DOP_fit(:,:,1);
ind=[16:180 1:15]; % Move left side to right
    DOP_fit_1=DOP_fit_1(:,ind);
    YT=grid.YT(:,ind);
    XT=grid.XT(:,ind);XT(XT>30)=XT(XT>30)-360; %...and subtract 360 to some longitudes


    
% make the figure, use m_map package
% m_map package: https://www.eoas.ubc.ca/~rich/map.html
hold on
m_proj('robinson','lon',[-330 30]); % Specify map domain
m_contourf(XT,YT,DOP_fit_1,50,'LineStyle','none','EdgeColor','none');
colormap(cmocean('balance'));
colorbar;
caxis([0 0.5]);
h=colorbar;
set(get(h,'ylabel'),'String','DOP (µM)','fontsize',20);
m_coast('patch',[.6 .6 .6]);
m_grid('box','fancy','linestyle','-','gridcolor','none','backcolor',[1 1 1],...
     'fontsize',20);
 m_scatter(data.LONGITUDE,data.LATITUDE,[],data.MeanDOPUpper50,'filled','o',...
     'MarkerEdgeColor','k')

set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',16,'FontWeight','Bold', 'LineWidth', 2);
set(gca, 'Units', 'centimeters', 'Position', [2, 2, 25, 15]);

