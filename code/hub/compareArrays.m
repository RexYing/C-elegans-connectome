function score=compareArrays(arr1,arr2,w1,w2)

%for now, score is % of cells shared between arrays. Eventually might use
%weights in w1 and w2 to create more nuanced similarity scores.
numTargets=length(arr1)+length(arr2);
numUnique=length(unique([arr1;arr2]));
numShared=numTargets-numUnique;
score=100*(numShared/numUnique);