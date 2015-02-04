% extract electric junctions from C.elegans connectome
% Just for initial experiment.
% Rex
%
% Electric Junctions only (the adjacency matrix is symmetric)
clear

% data from http://www.wormatlas.org/neuronalwiring.html
% under 2 Neuronal Connectivity II: by L.R. Varshney, B.L. Chen, E. Paniagua, D.H. Hall and D.B. Chklovskii
% Section 2.1 Connectivity Data (excel file)
%
% This data was first discussed by Chen, Hall, and Chklovskii, in 
% "Wiring optimization can relate neuronal structrure and function", 
% PNAS, March 21, 2006 103: 4723-4728 (doi:10.1073/pnas.0506806103).

[N,T,R] = xlsread('data/herm/NeuronConnect.xls');

% select the rows that correspond to Electric Junctions
ii = find(strcmp(T(:,3),'EJ'));

% find all unique node labels within the first two columns
[nodeLabel,iL,iData] = unique([R(ii,1); R(ii,2)]);
% note that iData is the same as [R(:,1); R(:,2)] 
% but with the indices of the nodes not the label

n = length(nodeLabel); % number of nodes
m = length(ii);        % number of edges

% compose adjacency matrix
A = zeros([n,n]);
for i = 1:m
  A(iData(i),iData(m+i)) = R{ii(i),4};
end

% display adjacency
figure(1)
spy(A)
title('Adjacency Matrix')

% display connectivity
% *** IT TAKES A LOT OF TIME, COMMENT OUT AFTER YOU SEE IT ***
figure(2)
gh = biograph(A,nodeLabel);
view(gh)

