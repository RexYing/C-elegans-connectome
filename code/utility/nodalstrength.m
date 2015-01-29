function [inStrengthList, outStrengthList ] = nodalstrength( adjMat )
%
% Compute in/out nodal strength of each vertex of a graph represented by a sparse
% adjacency matrix.
%
% SYNTAX
%
%   strengthList = computedegree( adjMat )
%   [inList, outList] = computedegree( adjMat )
%
% INPUT
%
%   adjMat      Adjacency matrix
%
% OUTPUT
%
%   inStengthList         [N-by-1] (N = number of vertices)
%                        sum of weights of afferent edges to each vertex
%   outStrengthList        [N-by-1]
%                        sum of weights of efferent edges from each vertex
%
%
% DESCRIPTION
%
%
% ALGORITHM
%
% If adjMat(a, b) = w, then the out-degree of vertex a is increased by w;
% the in-degree of vertex b is increased by w.
%
% ACKNOWLEDGEMENT
%
%
% DEPENDENCIES
%
%   NONE
%
% REFERENCES
%
%
% AUTHOR
%
%   Rex Ying       zy26@cs.duke.edu
%


% --------------------------------------------------------------------



nVertices = size(adjMat, 1);
inStrengthList = zeros(nVertices, 1);
outStrengthList = zeros(nVertices, 1);
for iNeuron = 1: nVertices
    outStrengthList(iNeuron) = sum(adjMat(iNeuron, :));
    inStrengthList(iNeuron) = sum(adjMat(:, iNeuron));
end

return 
