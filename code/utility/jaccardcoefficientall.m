function [ jaccard ] = jaccardcoefficientall( adjMat )
%
% Compute Jaccard Coefficient of each pair of vertices in a graph
%
% SYNTAX
%
%   jaccard = jaccardcoefficientall( adjMat )
%
% INPUT
%
%   adjMat      Adjacency matrix of a graph
%
% OUTPUT
%
%   jaccard         [N-by-N] (N = number of vertices)
%                        jaccard(i, j) entry is the jaccard coefficient for
%                        node pair (i, j).
%
%
% DESCRIPTION
% 
% The Jaccard similarity coecient of two nodes i and j is the size of 
% neighbors(i) intersect neighbors(j) divived by neighbors(i) union
% neighbors(j).
%
% ALGORITHM
%
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

jaccard = zeros(size(adjMat) );
for i = 1: size(adjMat, 1)
    % all neighbors of the first  vertex
    neighborsA = find(adjMat(i, :) );
    neighborsA = union(find(adjMat(:, i) ), neighborsA);
    
    for j = (i + 1): size(adjMat, 2)
        % all neighbors of the second vertex
        neighborsB = find(adjMat(j, :) );
        neighborsB = union(find(adjMat(:, j) ), neighborsB);
        jaccard(i, j) = length(intersect(neighborsA, neighborsB) ) / ...
            length(union(neighborsA, neighborsB) );
        jaccard(j, i) = jaccard(i, j);
    end

end

