function HUBS=HubAnalysis(A,names,scores,makeFigs)
%should output a struct of hubs with each class containing a list of
%neurons that the hub connects to (names and # of connections to each).
%
%could also have it output a plot to show how the hubs might be
%interconnected or share common targets. this hubplot would only contain
%the hubs and their targets.

[sortedScores,inds]=sort(scores,'descend');
sortedNames=names(inds);

hubInds=IdentifyHubs(sortedScores);
hubAdjMat=nan(length(hubInds),length(A));
hubNames=cell(length(hubInds),1);
for i=1:length(hubInds)
    currHub=sortedNames{hubInds(i)};
    hubDex=strcmp(names,currHub);
    hubDex=sum(hubDex.*[1:length(hubDex)]');
    HUBS.(sortedNames{hubInds(i)}).connectedCells=names(A(hubDex,:)~=0);
    tempWeights=A(hubDex,:);
    tempWeights(tempWeights==0)=[];    
    HUBS.(sortedNames{hubInds(i)}).connxnWeights=tempWeights;
    HUBS.(sortedNames{hubInds(i)}).totalCnnxns=scores(hubDex);
    hubNames{i}=sortedNames{hubInds(i)};
    hubAdjMat(i,:)=A(hubDex,:);
end
HUBS.hubAdjMat=hubAdjMat;
HUBS.hubNames=hubNames;
hubMat=HubComp(HUBS);
HUBS.hubMat=hubMat;

if makeFigs==true
    AdjMat2HubPlot(A)
    AdjMat2HubPlot(hubAdjMat,'Hub Subplot')
    MatrixHeatMap(hubMat,'Hub Similarities')
end