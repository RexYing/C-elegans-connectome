function [inDegreeList, outDegreeList ] = computedegree( adjMat )
%
% Compute in/out degree of each vertex of a graph represented by a sparse
% adjacency matrix.
%
% SYNTAX
%
%   degreeList = computedegree( adjMat )
%   [inList, outList] = computedegree( adjMat )
%
% INPUT
%
%   adjMat      Adjacency matrix
%
% OUTPUT
%
%   inDegreeList         [N-by-1] (N = number of vertices)
%                        number of afferent edges to each vertex
%   outDegreeList        [N-by-1]
%                        number of efferent edges from each vertex
%
%
% DESCRIPTION
%
%
% ALGORITHM
%
% If adjMat(a, b) = w, then the out-degree of vertex a is increased by 1;
% the in-degree of vertex b is increased by 1.
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
inDegreeList = zeros(nVertices, 1);
outDegreeList = zeros(nVertices, 1);
for iNeuron = 1: nVertices
    outDegreeList(iNeuron) = nnz(adjMat(iNeuron, :));
    inDegreeList(iNeuron) = nnz(adjMat(:, iNeuron));
end

return 
