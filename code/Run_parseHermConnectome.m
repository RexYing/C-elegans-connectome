% chemical/electrical junction of C.elegans connectome
% Rex Ying
%
clear all
close all

% data from http://www.wormatlas.org/neuronalwiring.html
% under 2 Neuronal Connectivity II: by L.R. Varshney, B.L. Chen, E. Paniagua, D.H. Hall and D.B. Chklovskii
% Section 2.1 Connectivity Data (excel file)
%
% This data was first discussed by Chen, Hall, and Chklovskii, in 
% "Wiring optimization can relate neuronal structrure and function", 
% PNAS, March 21, 2006 103: 4723-4728 (doi:10.1073/pnas.0506806103).

%% Read neuron connect data from file
%
% S: Send or output (Neuron 1 pre-synaptic to Neuron 2); 
% Sp: Send-poly (Neuron 1 is pre-synaptic to more than one postsynaptic 
%   partner.  Neuron 2 is just one of these post-synaptic neurons. 
%   In Whiteet al, 1986, these polyadic synaptic connections were denoted 
%   by â€œmâ€?in the tables of Appendix 1);
% R: Receive or input (Neuron 1 is post-synaptic to Neuron 2); 
% Rp: Receive-poly (Neuron 1 is one of several post-synaptic partners of 
%   Neuron 2.);
% EJ: Electric junction;
% NMJ: Neuromuscular junction (only reconstructed NMJ's are represented). 
%

figureCount = 1;

fileName = 'data/herm/NeuronConnect.csv';
neuronFileId = fopen(fileName);
if (neuronFileId < 0)
    error('invalid file name');
end

rawData = textscan(neuronFileId, '%s%s%s%d', 'Delimiter', ',', 'HeaderLines', 1);

column = rawData(1);
firstNeuronArray = column{1, :};
column = rawData(2);
secondNeuronArray = column{1, :};
column = rawData(3);
synapsisTypeArray = column{1, :};
column = rawData(4);
weightArray = column{1, :};

% indices of NMJ in rawData (to be excluded)
nmjIndices = find(strcmp(synapsisTypeArray, 'NMJ'));

edgeIndices = 1: size(weightArray, 1);
edgeIndices = setdiff(edgeIndices, nmjIndices);
nJunction = size(edgeIndices, 2); % edgeIndices: row vector


% find all unique node labels within the first two columns
[nodeLabel,iNeuronArray,iNodeLabel] = unique([firstNeuronArray(edgeIndices); ...
    secondNeuronArray(edgeIndices)]);
%
% nodeLabel contains 279 neuron names
% NMJ and VC06 appear in the data file but are not included in the
% nodeLabel
%
% NMJ: neuron muscular junction
% VC06: only connect to NMJ
%
nNeuron = size(nodeLabel, 1);
fprintf('Number of Neurons: %d\n', nNeuron);


%% adjacency matrix for gap junctions
%
% sparse matrix
%
%
gapJunctionIndices = find(strcmp(synapsisTypeArray, 'EJ')); % indices of EJ in rawData
nodeListGap1 = zeros(size(gapJunctionIndices, 1), 1);
nodeListGap2 = zeros(size(gapJunctionIndices, 1), 1);
for iGap = 1: size(gapJunctionIndices, 1)
    nodeListGap1(iGap) = iNodeLabel(gapJunctionIndices(iGap));
    nodeListGap2(iGap) = iNodeLabel(gapJunctionIndices(iGap) + nJunction);
end
adjHermGapJunctionSparse = sparse(nodeListGap1, nodeListGap2, double(weightArray(gapJunctionIndices)) );
degreeSymm = norm( adjHermGapJunctionSparse - adjHermGapJunctionSparse', 'fro');       % measure for non-symmetry 

figure(figureCount); figureCount = figureCount + 1;
spy(adjHermGapJunctionSparse);
title('Adjacency matrix for Gap Junctions');


%% Use Bioinformatics Toolbox for graph computations
%
% Path Length
%

% electric junction graph
graphEj = biograph(adjHermGapJunctionSparse, nodeLabel);
adjHermGapJunctionUnweighted = (adjHermGapJunctionSparse > 0);
graphEjUnweighted = biograph(adjHermGapJunctionUnweighted, nodeLabel);
% view graph (slow)
% view(graphEj);

% use unweighted graph. (1 when there is connection; 0 when there is not a
% connection
% all shortest paths
% allShortestEj: [nNeuron-by-nNeuron]
allShortestEj = allshortestpaths(graphEjUnweighted);
% paths that are not infinity or 0
pathIndex = find(isfinite(allShortestEj) & (allShortestEj ~= 0) );
allPathsEj = allShortestEj(pathIndex);
fprintf('Average path length for electric junction network: %d\n', mean(allPathsEj) );

figure(figureCount); figureCount = figureCount + 1;
hist(allPathsEj, 20); % slow
title('Histogram of Path Length for Herm Gap Junction Network');
xlabel('Path Length');
ylabel('Number of Paths');


%% Local Measures
%
% Jaccard Coefficient
%jaccardGap = jaccardcoefficientall(adjHermGapJunctionSparse); %slow

% Cluster Coefficient
clusterCoeffGap = clustercoeffs(adjHermGapJunctionSparse);



%% Adjacency Matrix for chemical junctions
% chemical junctions are directed.
%

chemJunctionIndices = setdiff(edgeIndices, gapJunctionIndices); % 1-by-N

% 
% construct sparse matrix for chemical junctions
nodeListChem1 = zeros(size(chemJunctionIndices, 2), 1);
nodeListChem2 = zeros(size(chemJunctionIndices, 2), 1);
for iChem = 1: size(chemJunctionIndices, 2)
    switch synapsisTypeArray{chemJunctionIndices(iChem)}
        case {'R', 'Rp'}
            nodeListChem2(iChem) = iNodeLabel(chemJunctionIndices(iChem));
            nodeListChem1(iChem) = iNodeLabel(chemJunctionIndices(iChem) + nJunction);
        case {'S', 'Sp'}
            nodeListChem1(iChem) = iNodeLabel(chemJunctionIndices(iChem));
            nodeListChem2(iChem) = iNodeLabel(chemJunctionIndices(iChem) + nJunction);
        otherwise
    end
end
adjHermChemJunctionSparse = sparse(nodeListChem1, nodeListChem2, double(weightArray(chemJunctionIndices)) );

% measure for non-symmetry
degreeSymm = norm( adjHermChemJunctionSparse - adjHermChemJunctionSparse', 'fro');       
fprintf('Degree of non-symmetry for chemical junctions: %d\n', degreeSymm);

figure(figureCount); figureCount = figureCount + 1;
spy(adjHermChemJunctionSparse);
title('Adjacency Matrix for Chemical Junctions');

