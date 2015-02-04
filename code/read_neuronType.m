% read_neuronType.m 
% 
% This script reads in the type of neurons (sensory/inter/motor)
% and record them in the same order as nodeLabel
%
% The output is stored in nodeType.
%
% 0: sensory neurons
% 1: interneurons
% 2: motor neurons
%
% Data Source: White et al. 1986
%
% Rex Ying
%

fileName = '../Data/Herm_Data/NeuronNames.txt';
neuronFileId = fopen(fileName);

if (neuronFileId < 0)
    error ( [ 'failed open the file', fileName ] ); 
end

rawData = textscan( neuronFileId, '%s%s%s');

column      = rawData(1);
neuronArray = column{1, :};

column      = rawData(3);
typeArray   = column{1, :};

nodeType = zeros(size(nodeLabel));
for iNeuron = 1: length(neuronArray)
    index = find(strcmp(nodeLabel, neuronArray(iNeuron) ) );
    if strcmp(typeArray{iNeuron}, 'in')
        nodeType(iNeuron) = 0;
    elseif strcmp(typeArray{iNeuron}, 'se')
        nodeType(iNeuron) = 1;
    else
        nodeType(iNeuron) = 2;
    end
end
