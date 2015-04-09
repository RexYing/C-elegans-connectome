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

%scatter(xx, yy, '.');

%% match node labels
neuron_types;
load 'nodelabel279.mat'
fileName = 'celegans277labels.csv';
fileId = fopen(fileName);
rawData = textscan(fileId, '%s', 'Delimiter', ',', 'HeaderLines', 0);
label277 = rawData{1};

%% plot
figure
scatter(xx(motorIdx), yy(motorIdx), 'm.');
scatter(xx(sensoryIdx), yy(sensoryIdx), 'g.');
scatter(xx(interIdx), yy(interIdx), 'b.');
d = 0.01;
text(xx+d, yy + d, label277);
axis equal
title ('The 2D embedding of neuron positions');



