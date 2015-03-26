function [ColorMat,ColorMap]=HeatMapGen(data,maxVal)
%ColorMap is the 64x3 color matrix. ColorMat projects ColorMap onto the
%dimensions of input data.
%
%Justin O'Hare
%ohare@neuro.duke.edu
data(isnan(data))=0;
if size(data,1)<size(data,2)
    data=data';
end

%create color map
ColorMap=redblue;
ColorMat=zeros(length(data),3);
mapLength=size(ColorMap,1);
mapLength=mapLength*(max(data)/maxVal);
    
I=rankedInds(data);
for i=1:length(I)
    colorInd=floor((I(i)/length(data))*mapLength);
    if colorInd<1 || isnan(colorInd), colorInd=1;end
    ColorMat(i,:)=ColorMap(colorInd,:);
end


