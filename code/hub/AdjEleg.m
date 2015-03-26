function [A,names,scores,HUBS]=AdjEleg(varargin)
%
%PLAN: include input excludedNodes as cell array of strings for neurons to
%take out of raw data before making adjacency matrix
%
%inputs:
%   arg 1: rawData is just the connectome excel sheet imported as one big cell array
%
%   arg 2: mode is 'primary' or 'secondary' depending on how deep the adjacency
%          matrix should go
%
%   arg 3: cellsToExclude is a cell array of cell names to be
%          excluded from rawData when making A
%
%   arg 4: makeFigs is a boolean indicating whether or not to make
%          hub-related figures in call to HubAnalysis
%
%outputs:
%   A: adjacency matrix, weighted by # of connections
%   scores: number of connections for each index
%   names of neurons indexed in scores
%   index 'i' in this cell array contains an array of indices for 'names'
%   that identifies which neurons are connected to the 'i'th neuron in
%   'names'.
%   HUBS: struct of each hub identified by HubAnalysis.m. Each class
%   contains list of cells it connects to, the weights, and # of total
%   connections. struct also has a sub-adjancy matrix that is H x N for H
%   hubs.
%
%v1.0 | Justin - 1/28/15
%% read in vars
mode='primary'; cellsToExclude={}; makeFigs=true;%default settings

varNames={'rawData','mode','cellsToExclude','makeFigs'};
for varDex=1:length(varargin)
    eval(sprintf('%s=varargin{varDex};',varNames{varDex}))
end

%% prepare data for processing into A
if strcmp(rawData{1,1},'Neuron 1')
    rawData=rawData(2:end,:);%clip data labels
end

rawData(:,1:2)=upper(rawData(:,1:2));%all upper case

if ~isempty(cellsToExclude)
    rawData=ClipNodes(rawData,cellsToExclude);
end

names=unique([rawData(:,1);rawData(:,2)]);%list of cell names. draw from both 
%columns because of some peripheral cells (e.g. muscle cells) that only RECEIVE
%input

%% make A
%for each connected neuron in col2, find its index in 'names' so that A can
%be symmetrically indexed (not symetrically populated though- directed).
n2Inds=nan(size(rawData,1),1);%keeps index of every col 2 cell for 'names'
for i=1:length(n2Inds)
    isConn=strfind(names,rawData{i,2});%
    indsConn=cell2mat(cellfun(@sum,isConn,'UniformOutput',false));
    indsConn=(indsConn==1); %somtimes you get >1 because internal matches
    indConn=sum(indsConn.*[1:length(indsConn)]');%turn logical array to 
    %index array and extract single index
    n2Inds(i)=indConn;
end

A=zeros(length(names));
ScoresByName=cell(length(names),2);
cnnxnInds=cell(length(names),1);
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

%% extra outputs
scores=CalcDegrees(A,mode);%node degrees
HUBS=HubAnalysis(A,names,scores,makeFigs);

