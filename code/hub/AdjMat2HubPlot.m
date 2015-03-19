function AdjMat2HubPlot(A,varargin)
%Takes adjacency matrix A as input and generates hub plot
%
%things to consider: 
    %weighting number of connections by number of unique target nodes in
    %addition to total number of afferent vertices
    %
%functions called:
    %HeatMapGen.m
    %rankedInds.m
    %redblue.m
%
%Justin O'Hare, 2/09/15
%ohare@neuro.duke.edu
%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(varargin)
    titleText=varargin{1};
end

A(isnan(A))=0;
scaleFactor=4;
hubScores=sum(A,2);
sizes=hubScores*scaleFactor+eye;
N=max(size(A));
angleInt=2*pi/N;
xCoords=zeros(N,1);
yCoords=zeros(N,1);
cellDex=1;

%assign coordinates to cells
for angle=0:angleInt:(2*pi-2*pi/N)
    xCoords(cellDex)=N*cos(angle);
    yCoords(cellDex)=N*sin(angle);
    cellDex=cellDex+1;
end

%plot the data
[heatMap,ref]=HeatMapGen(hubScores,max(hubScores));
figure
for i=1:size(A,1)
    if size(A,1)<N
        j=i*(floor(N/length(hubScores)));
        J(i)=j;
    else
        j=i;
    end
    tempColor=[rand rand rand];
    cnnxnInds=(A(i,:)~=0).*[1:N];
    cnnxnInds(cnnxnInds==0)=[];
    numCnnxns=length(cnnxnInds);%not # of vertices, but # of connected nodes
    X=[repmat(xCoords(j),1,numCnnxns);xCoords(cnnxnInds)'];
    Y=[repmat(yCoords(j),1,numCnnxns);yCoords(cnnxnInds)'];
    line(X,Y,'Color',tempColor)
    hold on
end
if size(A,1)<N %if only showing connections from subset of cells ('hubs')
    sizes2=repmat(min(sizes)/100,N,1);
    heatMap2=zeros(N,3);
    for i=1:length(J)
        sizes2(J(i))=sizes(i);
        heatMap2(J(i),:)=heatMap(i,:);
    end
    sizes=sizes2;clear sizes2
    heatMap=heatMap2; clear heatMap2
    
end    
scatter(xCoords,yCoords,sizes,heatMap,'filled')
hold off
colormap(ref);
colorbar('YTickLabel',{sprintf('%0.1f',min(hubScores)),'','',''...
    '','','','','','',sprintf('%0.1f',max(hubScores))});
if ~exist('titleText','var')
    titleText='HubPlot';
end
title(titleText)
