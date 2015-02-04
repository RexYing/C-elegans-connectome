% Spectral analysis
% Rex Ying
%
% DEPENDENCIES
%
%   Run_parseHermConnectome
%   Run_cluster
%
close all

%% EJ
% laplacian of the giant component of EJ network
figureCount = 1;

adjGiantComp = AgapHermSparse(giantCompIndices, giantCompIndices);
nNeuronGiantComp = size(adjGiantComp, 1);

% Eigenvectors and eigenvalues
[ Stats, vGiantComp, diagGiantComp, indices ] = homotopiceig( adjGiantComp, ...
    0, 'Normalize', false );


%plot the eigenvalues
figure(figureCount); 
figureCount = figureCount + 1;
h = plotyy(1:nNeuronGiantComp,diag(diagGiantComp),1:nNeuronGiantComp, diagGiantComp ./10, 'bar');
xlabel('n','FontSize',16);
set(get(h(1),'Ylabel'),'String','\lambda_n','FontSize',16);
set(get(h(2),'Ylabel'),'String','estimated decay constant (1/ms)','FontSize',16);
set(h(1),'Xlim',[.6 248.4],'Ylim',[0 120],'FontSize',14);
set(h(2),'Xlim',[.6 248.4],'Ylim',[0 12],'FontSize',14);

figure(figureCount); 
figureCount = figureCount + 1;
semilogy(1:nNeuronGiantComp, diagGiantComp);

% plot survival function
[eigenvalueAxis, percentAxis] = survivalfunction(diagGiantComp);

figure(figureCount); 
figureCount = figureCount + 1;
loglog(eigenvalueAxis, percentAxis, '-');
title('Survival Function for eigenvalues');
xlabel('log Eigenvalue');
ylabel('log Percentage');


%% Enbedding
% ... get the chosen eigenvectors 

step = 3;
start = 2;
inds = start: step: start + step * 2;

% Plot
spectralenbedding(adjGiantComp, vGiantComp, diag(diagGiantComp), inds);


%% L1 norm of eigenvectors (measure sparseness); degree; strength
% Sparse eigenvectors have few entries whos absolute values are relatively
% significant

l1Norms = sum(abs(vGiantComp), 1);
[l1Norms, l1NormsIndices] = sort(l1Norms, 'ascend');

% some inds for spectral enbedding
inds1 = [l1NormsIndices(1), l1NormsIndices(2), l1NormsIndices(4)]; % most sparse

giantCompDegree = computedegree(adjGiantComp);
giantCompStrength = computedegree(adjGiantComp);


%% Normalized Laplacian

[ Stats, vNormGiantComp, diagNormGiantComp, indNormGC ] = homotopiceig( adjGiantComp, ...
    0, 'Normalize', true );

% Plot
%semilogy(1:nNeuronGiantComp, diagNormGiantComp);

inds = 246:1:248; % largest

spectralenbedding(adjGiantComp(indNormGC, indNormGC), vNormGiantComp, diagNormGiantComp, inds);

