function A=AdjEleg(rawData)
%input is just the connectome excel sheet imported as one big cell array
%output is the adjacency matrix, weighted by # of connections 
%
%v1.0 | Justin - 1/28/15
rawData=rawData(2:end,:);%clip data labels
rawData(:,1:2)=upper(rawData(:,1:2));%all upper case
names=unique([rawData(:,1);rawData(:,2)]);%list of cell names. draw from both 
%columns because of some peripheral cells (e.g. muscle cells) that only RECEIVE
%input

%for each connected neuron in col2, find its index in 'names' so that A can
%be symmetrically indexed (not symetrically populated though- directed).
n2Inds=nan(size(rawData,1),1);%keeps index of every col 2 cell for 'names'
for i=1:length(n2Inds)
    isConn=strfind(names,rawData{i,2});
    indsConn=cell2mat(cellfun(@sum,isConn,'UniformOutput',false));
    indsConn=(indsConn==1); %somtimes you get >1 because internal matches
    indConn=sum(indsConn.*[1:length(indsConn)]');%turn logical array to 
    %index array and extract single index
    n2Inds(i)=indConn;
end

A=zeros(length(names));
%loop through each cell type and record connected cells into A
for i=1:length(names)
    %find indices for current cell
    isCurr=strcmp(rawData(:,1),names(i));
    indsCurr=isCurr.*[1:length(isCurr)]';
    zeroInds=(indsCurr==0);
    indsCurr(zeroInds)=[];%leaves only indices of connected cells    
    numCnxns=cell2mat(rawData(indsCurr,4));%number of connections @ same indices
    A(i,n2Inds(indsCurr))=numCnxns;%populate by back-indexing connected cell 
end