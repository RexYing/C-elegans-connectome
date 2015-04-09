figureCount = 1;

fileName = 'data/celegans_neuron_birth_times.csv';
neuronFileId = fopen(fileName);
if (neuronFileId < 0)
    error('invalid file name');
end

rawData = textscan(neuronFileId, '%s%f', 'Delimiter', ',', 'HeaderLines', 0);

column = rawData(1);
labelArray = column{1, :};
column = rawData(2);
birthtime = column{1, :};

inds = zeros(length(nodeLabel), 1);
for i = 1: length(nodeLabel)
    inds(i) = find(strcmp(nodeLabel{i}, labelArray));
end
birthtime = birthtime(inds);
