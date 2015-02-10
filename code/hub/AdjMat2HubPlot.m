function AdjMat2HubPlot(A)
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
hubScores=sum(A,2);
N=size(A,1);
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
for i=1:N
    tempColor=[rand rand rand];
    cnnxnInds=(A(i,:)~=0).*[1:N];
    cnnxnInds(cnnxnInds==0)=[];
    numCnnxns=length(cnnxnInds);%not # of vertices, but # of connected nodes
    X=[repmat(xCoords(i),1,numCnnxns);xCoords(cnnxnInds)'];
    Y=[repmat(yCoords(i),1,numCnnxns);yCoords(cnnxnInds)'];
    line(X,Y,'Color',tempColor)
    hold on
end
scatter(xCoords,yCoords,hubScores*2+eye,heatMap,'filled')
hold off
colormap(ref);
colorbar('YTickLabel',{'0','','',''...
    '','','','','','',sprintf('%0.1f',max(hubScores))});
title('c. Elegans Connectome Hub Plot')
