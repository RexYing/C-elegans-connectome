function dataOut=ClipNodes(dataIn,excludedCells)
%for removing rows containing any strings in cell array excludedCells. This
%array could contain cell names, connection types, or connection counts.
%basically anything c. Elegans data set.

for cellDex=1:length(excludedCells)
    excludeInds=strcmp(excludedCells{cellDex},dataIn);
    excludeInds=(sum(excludeInds,2)>0);
    excludeInds=excludeInds.*[1:length(excludeInds)]';
    keepInds=(excludeInds==0);
    excludeInds(keepInds)=[];%leaves only indices of connected cells    
    dataIn(excludeInds,:)=[];
end
dataOut=dataIn;

