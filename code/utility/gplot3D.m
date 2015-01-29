function [Xout,Yout, Zout] = gplot3D( A, xyz, lc )
% 
% GPLOT3d Plots a graph in 3D 
% 
% Calling sequences 
%   gplot3D( A, xyz, lc ) ;
%   [X,Y, Z] = gplot3D (A,xyz, lc ) ; 
% 
%  Input: 
%  A : adjacency matrix for an undirected graph without 
%      self-loops 
%  xyz : Nx3 array, xyy(i) contains three coordinates 
%        for node i 
%  cl  : specify line type and color for the display 
%        same as for plot(...) 
%   
% 
%  Output (if required) 
%   Xout, Yout, Zout are the NaN-punctuated vectors
%   for generating the plot at a later  time if desired. 
%   The array xyz are floating point numbers in single 
%   or double precision 
%   
%   See also gplot 

% ---------------------------------------------------
% Xiaobai Sun 
% Duke CS 
% For Numerical Analysis Class 
% Nov. 1, 2011 
% Contact xiaobai for any further distribution 
% ---------------------------------------------------



% --------------------------------------------------------------------



[i,j] = find(A);             % row and column indices for nonzero elements
[~, p] = sort(max(i,j));     
i = i(p);
j = j(p);

X = [ xyz(i,1) xyz(j,1)]';
Y = [ xyz(i,2) xyz(j,2)]';
Z = [ xyz(i,3) xyz(j,3)]';

if isfloat(xyz) || nargout ~= 0
    X = [X; NaN(size(i))'];
    Y = [Y; NaN(size(i))'];
    Z = [Z; NaN(size(i))'];
end

if nargout == 0
    if ~isfloat(xyz)
        if nargin < 3
            lc = '';
        end
        [lsty, csty, msty] = gplotGetRightLineStyle(gca,lc);    
        plot3(X,Y,Z, 'LineStyle',lsty, 'Color',csty,' Marker', msty);
    else
        if nargin < 3
            plot3(X(:),Y(:),Z(:) );
        else
            plot3(X(:),Y(:), Z(:), lc);
        end
    end
else
    Xout = X(:);
    Yout = Y(:);
    Zout = Z(:); 
end

return 


function [lsty, csty, msty] = gplotGetRightLineStyle(ax, lc)
%  
%    gplotGetRightLineStyle
%    Helper function which correctly sets the color, line style, and marker
%    style when plotting the data above.  This style makes sure that the
%    plot is as conformant as possible to gplot from previous versions of
%    MATLAB, even when the coordinates array is not a floating point type.
% 

co = get(ax,'ColorOrder');
lo = get(ax,'LineStyleOrder');
holdstyle = getappdata(gca,'PlotHoldStyle');
if isempty(holdstyle)
    holdstyle = 0;
end
lind = getappdata(gca,'PlotLineStyleIndex');
if isempty(lind) || holdstyle ~= 1
    lind = 1;
end
cind = getappdata(gca,'PlotColorIndex');
if isempty(cind) || holdstyle ~= 1
    cind = 1;
end
nlsty = lo(lind);
ncsty = co(cind,:);
nmsty = 'none';
%  Get the linespec requested by the user.
[lsty,csty,msty] = colstyle(lc);
if isempty(lsty)
    lsty = nlsty;
end
if isempty(csty)
    csty = ncsty;
end
if isempty(msty)
    msty = nmsty;
end

return 
