% parse_gapMatrix_hermC.m 
% 
% This script parses the connectome data for C. elegans 
% in .csv format to adjacency matrices in sparse storage 
% in MATLAB 
% 
% The C. elegans connectome data are represented 
% in terms of chemical and electrical junctions. 
% 
% This script parses and extracts the symmetric adjacency 
% matrix associated with the gap junctions in the connectome 
% data fora C. elegans. It also displays and saves the matrix 
% for later use. 
% 
% See also the script ??? for parsing and extracting 
% the nonsymmetric matrix associated with chemical 
% junctions. 


%%  Data Source -- location and information : 
%  http://www.wormatlas.org/neuronalwiring.html
%  at the link to 2 Neuronal Connectivity II: 
%  by L.R. Varshney, B.L. Chen, E. Paniagua, D.H. Hall and D.B. Chklovskii
%  See Section 2.1 Connectivity Data (excel file)
%
% This data was first discussed by Chen, Hall, and Chklovskii, in 
% "Wiring optimization can relate neuronal structrure and function", 
% PNAS, March 21, 2006 103: 4723-4728 (doi:10.1073/pnas.0506806103).


clear all 
close all 

figureCount = 1;

%% Read neuron connect data from file
%
% S:  Send or output 
%     (Neuron 1 pre-synaptic to Neuron 2); 
%
% Sp: Send-poly 
%     (Neuron 1 is pre-synaptic to more than one postsynaptic 
%     partner.  Neuron 2 is just one of these post-synaptic neurons. 
%     
%     In White et al, 1986, these polyadic synaptic connections 
%     were denoted  by â€œmâ€?in the tables of Appendix 1);
%
% R:  Receive or input 
%     (Neuron 1 is post-synaptic to Neuron 2); 
%
% Rp: Receive-poly 
%     (Neuron 1 is one of several post-synaptic partners of Neuron 2.);
%
% EJ: Electric junction;
%
% NMJ: Neuromuscular junction 
%      (only reconstructed NMJs are represented). 
%


fileName = 'Data/Herm_Data/NeuronConnect.csv';
neuronFileId = fopen(fileName);

if (neuronFileId < 0)
    error ( [ 'failed open the file', fileName ] ); 
end


rawData = textscan( neuronFileId, ... 
                    '%s%s%s%d', 'Delimiter', ',', 'HeaderLines', 1);

% 
% xiaobai noted that : 
%     need to document the data structures such as 'column' 
%     A. may help here 

% pre-synapse
column            = rawData(1);
firstNeuronArray  = column{1, :};

% post-synapse
column            = rawData(2);
secondNeuronArray = column{1, :};

% synapse type
column            = rawData(3);
synapsisTypeArray = column{1, :};

% weight (multiplicity)
column            = rawData(4);
weightArray       = column{1, :};


% ... indices of NMJ in rawData to be excluded

nmjIndices = find(strcmp(synapsisTypeArray, 'NMJ'));

edgeIndices = 1: size(weightArray, 1);
edgeIndices = setdiff(edgeIndices, nmjIndices);
nJunction   = size(edgeIndices, 2);             % edgeIndices: row vector


% ... find all unique node labels within the first two columns

[nodeLabel,iNeuronArray,iNodeLabel] = ... 
        unique( [ firstNeuronArray(edgeIndices); ...   
                  secondNeuronArray(edgeIndices)] );
%
% nodeLabel contains 279 neuron names/labels,  not including 
% NMJ and VC06, which  appear in the data file 
%
% NMJ:  neuron muscular junction
% VC06: only connect to NMJ
%

nNeuron = size(nodeLabel, 1);


%% adjacency matrix for gap junctions
%
% symmetric and stored in sparse storage format 
%

gapJunctionIndices = find(strcmp(synapsisTypeArray, 'EJ')); 
                                     % indices of EJ in rawData
nodeListGap1 = zeros(size(gapJunctionIndices, 1), 1);
nodeListGap2 = zeros(size(gapJunctionIndices, 1), 1);

for iGap = 1: size(gapJunctionIndices, 1)
    nodeListGap1(iGap) = iNodeLabel(gapJunctionIndices(iGap));
    nodeListGap2(iGap) = iNodeLabel(gapJunctionIndices(iGap) + nJunction);
end

AgapHermSparse = sparse( nodeListGap1, nodeListGap2, ...
                               double(weightArray(gapJunctionIndices)) );

% ... check on the symmetry of the adjacency matrix 

degreeSymm = norm( AgapHermSparse - AgapHermSparse', ...
                   'fro' );       % a measure for non-symmetry 

if degreeSymm > eps 
    error ( 'the gap junction matrix is non-symmetric' ) ;
end

% ... display the adjacency matrix 

figure(figureCount); 
figureCount = figureCount + 1;

spy( AgapHermSparse );
title('Adjacency matrix by the Gap Junctions of C. Elegans');
Bstring = sprintf( ' %d x %d Symmetric Matrix ', nNeuron, nNeuron );
ylabel( Bstring ) 

saveFile = 'AgapCherm.mat';
save( saveFile , 'AgapHermSparse', 'nodeLabel' ) ; 
Bstring = sprintf( '\n The adjRun_parseHermConnectomeacency matrix is saved in ' ); 
disp( [ Bstring, saveFile ] ) ;
disp( ' ' ) ; 


return 


% ----------------------------------------------------------
% Initial created by 
% Rex Ying 
% May 2013 
% 
% Edited by 
% Xiaobai Sun and Aleandros  
% June 2013 
% 
% Department of Computer Science, Duke University 
%-------------------------------------------------------------
