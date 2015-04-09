function [ ] = embedSubnetwork( label, A, X, selectedNames )
%EMBEDSUBNETWORK Summary of this function goes here
%   X: [n-by-3] matrix each row corresponding to the coordinate of an embedded node
%   A: Adjacency matrix
%   label: neuron labels by which X and A are ordered
%

if iscell(selectedNames)
    inds = zeros(length(label), 1);
    for i = 1: length(selectedNames)
        new = ismember(label, selectedNames(i));
        if any(new) % found that label
            inds = inds + new;
        else % otherwise try append 'L' and 'R'
            new = ismember(label, [selectedNames{i}, 'L']) + ismember(label, [selectedNames{i}, 'R']);
             if any(new)
                inds = inds + new;
             else % otherwise append number 01-13 (motor neurons)
                 for j = 1: 13
                     inds = inds + ismember(label, [selectedNames{i}, sprintf('%02d', j)]);
                 end
             end
        end
    end
    inds = find(inds);
else
    inds = selectedNames; % assume they are indices already
end

neuron_types;
h = figure ; 

hold on 
plot3( X(motorIdx,1), X(motorIdx,2), X(motorIdx,3), 'm.');
plot3( X(sensoryIdx,1), X(sensoryIdx,2), X(sensoryIdx,3), 'g.');
plot3( X(interIdx,1), X(interIdx,2), X(interIdx,3), 'b.');
xlabel( 'V 1') 
ylabel( 'V 2' )
zlabel( 'V 3' )
gplot3D( A(inds, inds), X(inds,1:3) );
title('colored 3D spectral embedding of A');
grid on 
box on 
rotate3d 
d = 0.01;
text(X(inds, 1)+d, X(inds, 2)+d, X(inds, 3) + d, label(inds));

end

