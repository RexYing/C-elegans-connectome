function MatrixHeatMap(varargin)
titleText='';
varNames={'M','titleText'};
for varDex=1:length(varargin)
    eval(sprintf('%s=varargin{varDex};',varNames{varDex}))
end
figure
colormap(redblue)
imagesc(M)
title(titleText)
colorbar
