function hubMat=HubComp(HUBS)
%
%hubMat is an adjacency matrix for hubs where weights are similarity scores
%calculated in compareArrays.
hubNames=HUBS.hubNames;
hubMat=nan(length(hubNames));

for hubDex=1:length(hubNames)
    for compDex=1:length(hubNames)
        targetsPrimary=HUBS.(hubNames{hubDex}).connectedCells;
        targetsSecondary=HUBS.(hubNames{compDex}).connectedCells;
        weightsPrimary=HUBS.(hubNames{hubDex}).connxnWeights;
        weightsSecondary=HUBS.(hubNames{hubDex}).connxnWeights;
        simScore=compareArrays(targetsPrimary,targetsSecondary,weightsPrimary,weightsSecondary);
        hubMat(hubDex,compDex)=simScore;
    end
end
        