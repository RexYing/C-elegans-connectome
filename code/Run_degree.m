% Display degree information
%
% Rex Ying
%
% DEPENDENCIES
%
%   Run_parseHermConnectome
%
%% Gap junction degree
% get degree and strength for each node and plot in non-increasing order
%
% Note degree and strength are sorted individually:
% Neuron that has the largest degree may not have the largest nodal strength
% Index of neuron stored in gapDegreeIndices and gapStrengthIndices
%
% degree
[gapDegree, ~] = computedegree(adjHermGapJunctionSparse);
figure(figureCount); figureCount = figureCount + 1;
xAxis = 1: nNeuron;
[gapDegree, gapDegreeIndices] = sort(gapDegree, 'descend');

plot(xAxis, gapDegree, '.');
% semilogy(xAxis, gapJunctionDegreeList, '.');
title('Gap Junction Degrees in Descending Order');
xlabel('Neurons');
ylabel('Degree');

%% Chem degree
%
% get degree
[chemInDegree, chemOutDegree] = computedegree(adjHermChemJunctionSparse);
% get degree figure and hold on
% plot in the order of gapDegreeIndices
figure(figureCount - 1);
hold on;
plot(xAxis, chemInDegree(gapDegreeIndices), '.', 'Color', 'red');
hold on;
plot(xAxis, chemOutDegree(gapDegreeIndices), '.', 'Color', 'black');



%% Gap junction strength

[gapJunctionNodalStrengthList, ~] = nodalstrength(adjHermGapJunctionSparse);
figure(figureCount); figureCount = figureCount + 1;
xAxis = 1: nNeuron;
[gapJunctionNodalStrengthList, gapStrengthIndices] = sort(gapJunctionNodalStrengthList, 'descend');

plot(xAxis, gapJunctionNodalStrengthList, '.');
% semilogy(xAxis, gapJunctionNodalStrengthList, '.');
title('Gap Junction Nodal Strengths in Descending Order');
xlabel('Neurons');
ylabel('Strength');

spearmanRho = corr(gapStrengthIndices, gapDegreeIndices, 'type', 'Spearman');


%% Survival Function for Gap Junction degrees
% (the complement of cumulative distribution function)
%
% Degree
%
[degreeAxis, percentAxis] = survivalfunction(gapDegree);

%plot(degreeAxis, percentAxis, '.');
figure(figureCount); figureCount = figureCount + 1;
loglog(degreeAxis, percentAxis, '-');
title('Survival Function for Degrees of Gap Junction Network');
xlabel('log(Degree)');
ylabel('log(Percentage)');

%% sort chem indegree/outdegree
[chemInDegree, chemInDegreeIndices] = sort(chemInDegree, 'descend');
[chemOutDegree, chemOutDegreeIndices] = sort(chemOutDegree, 'descend');

