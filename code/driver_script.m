%% Load neuron positions

fileName = 'data/celegans277positions.csv';
neuronFileId = fopen(fileName);
if (neuronFileId < 0)
    error('invalid file name');
end

rawData = textscan(neuronFileId, '%f%f', 'Delimiter', ',', 'HeaderLines', 0);

column = rawData(1);
xx = column{1, :};
column = rawData(2);
yy = column{1, :};

scatter(xx, yy, '.');
