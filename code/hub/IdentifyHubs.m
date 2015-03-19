function [hubInds,sortInds]=IdentifyHubs(scores)
%scores is Nx1 vector
%
%

numSDs=1;

scores(isnan(scores))=0;
[sortInds,scores]=rankedInds(scores,'descend');
scores=scores+1;

diffMat=scores-[scores(2:end);1];
thresh=mean(diffMat)+numSDs*std(diffMat);
hubThreshDex=find(diffMat>=thresh,1,'last');


hubInds=1:hubThreshDex;