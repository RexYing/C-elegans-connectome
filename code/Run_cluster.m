% cluster
% Rex Ying
%
% DEPENDENCIES
%
%   Run_parseHermConnectome
%

%% EJ
%
% 26 Isolated neurons
EjIsolatedIndices = zeros(nNeuron, 1);
index = 1;
for iNeuron = 1: nNeuron
    if nnz(AgapHermSparse(iNeuron, :)) == 0
        EjIsolatedIndices(index) = iNeuron;
        index = index + 1;
    end
end
EjIsolatedIndices = EjIsolatedIndices(EjIsolatedIndices > 0);

% 253 connected neurons which can be decoupled into 3 parts
% The name of the neuron i in the adjMat is nodeLabel(connNeurons(i)) 
connNeurons = 1: nNeuron;
connNeurons = setdiff(connNeurons, EjIsolatedIndices);
connEjAdjMat = AgapHermSparse(connNeurons, connNeurons);

%[V, D] = eigs(connEjAdjMat);
[nComponent, components] = graphconncomp(connEjAdjMat);

%giant component neurons
gc = mode(components);
giantCompIndices = find(components == gc);
for iNeuron = 1: size(giantCompIndices, 2)
    giantCompIndices(iNeuron) = connNeurons(giantCompIndices(iNeuron));
end

%list the smaller components
histComp = hist(components, nComponent);
nComp = 2;
for iComp = 1: nComponent
    if (histComp(iComp) > 1 ) && (iComp ~= gc)
        disp(strcat('Component ',num2str(nComp)));
        component = find(components == iComp);
        for iNeuron = 1: histComp(iComp)
            disp(nodeLabel(connNeurons(component(iNeuron))) );
        end
        nComp = nComp + 1;
    end
end