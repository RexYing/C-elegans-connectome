function cmap = redblue(m)
%Color map by Justin O'Hare
%ohare@neuro.duke.edu

% Default Colormap Size
if ~nargin
    m = 64;
end

colorPoints = [0 1 1; 0 .1667 1;0.366,0.060,0.295;.702 .0448 .0448;1 0 0];

y = -2:2;
if mod(m,2)
    delta = min(1,4/(m-1));
    half = (m-1)/2;
    y2 = delta*(-half:half)';
else
    delta = min(1,4/m);
    half = m/2;
    y2 = delta*nonzeros(-half:half);
end
cmap = interp2(1:3,y,colorPoints,1:3,y2);

