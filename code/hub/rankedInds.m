function inds=rankedInds(data)
%return list of indices ranking each entry in ascending order
%so if data(3) is 144th-highest value in data, inds(3)==144
inds=nan(length(data),1);
[~,I]=sort(data,1,'ascend');
for i=1:length(I)
    inds(i)=sum((I==i).*[1:length(I)]');
end
    