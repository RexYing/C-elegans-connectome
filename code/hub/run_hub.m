load data/herm/ImportedHermExcel.mat
%[A,names,scores,HUBS]=AdjEleg(NeuronConnect, 'primary');
% [A,names,scores,HUBS]=AdjEleg(NeuronConnect, 'secondary');
[A,names,scores,HUBS]=AdjEleg(NeuronConnect, 'primary', {'AVAL', 'AVAR', 'AVBR'});