function hubCounts=HubClipper(rawData)

hubCounts=zeros(size(rawData,1),1);

[~,~,~,HUBS]=AdjEleg(rawData,'primary',{},false);

clipCt=1; currSize=size(rawData,1);lastSize=currSize+1;
while ~isempty(HUBS.hubNames) && currSize<lastSize
    lastSize=size(rawData,1);
    numHubs=length(HUBS.hubNames);
    hubCounts(clipCt)=numHubs;
    clippedHub=HUBS.hubNames(1); %highest-degree hub
    fprintf('Removing hub %s from network of %1.0f connections\n',cell2str(clippedHub),size(rawData,1))
    rawData=ClipNodes(rawData,clippedHub);
    currSize=size(rawData,1);
    [~,~,~,HUBS]=AdjEleg(rawData,'primary',{},false);
    clipCt=clipCt+1;
end
hubCounts=hubCounts(1:clipCt);
