function [inds,sortedData]=rankedInds(varargin)
%return list of indices ranking each entry in ascending order
%so if data(3) is 144th-highest value in data, inds(3)==144
%
%direction is either 'ascend' or 'descend'. 'ascend' is default.
data=varargin{1};
if length(varargin)==1
    direction='ascend';
else
    direction=varargin{2};
end

inds=nan(length(data),1);

[sortedData,I]=sort(data,1,direction);
for i=1:length(I)
    inds(i)=sum((I==i).*[1:length(I)]');
end
    