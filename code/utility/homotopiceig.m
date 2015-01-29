function [ Stats, V, E, indices ] = homotopiceig( A, tau, varargin )
%
% Calculate eigenvalues and eigenvectors of graph Laplacian
% for a given tau as homotopy value
%
% SYNTAX
%
%   [Stats, V, E, indices] = homotopiceig(adjMat, tau)
%
% INPUT
%
%   A                   [N-by-N] Adjacency matrix
%   tau                 homotopy value (percentage for unweighted)
%
% OUTPUT
%
%   Stats               Structure that contains max, mean, median and
%                       std (standard deviation).
%   V                   [N-by-N] matrix
%                       Array of eigenvalues (sorted in ascending order)
%   E                   [N-by-1] vector
%                       E(i) is the eigenvector corresponding to V(i)
%   indices             The sorting order of V
%
% DESCRIPTION
%
% Analyze the eigenvalues and eigenvectors using homotopy, to combine
% both weighted and unweighted graph for the same network
%
% ALGORITHM
%
%   A(tau) = A1 * tau + Aw * (1 - tau), where A1 is the unweighted
% adjacency matrix and Aw is the weighted adjacency matrix.
%   L(tau) = D(tau) - A(tau)
%   eig(L(tau) )
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
%   Xiaobai Sun    xiaobai@cs.duke.edu
%

% option

normalize = false;
if strcmp(varargin(1), 'Normalize')
    val = varargin(2);
    if val{1}
        normalize = true;
    end
end

% apply tau to weight
% calcweight = @(x) tau + (1 - tau) * x;
% A = arrayfun(calcweight, A);
nonzeroInds = A ~= 0;
A(nonzeroInds) = tau + (1 - tau) * A(nonzeroInds);

if issparse(A)
    A = full(A);
end

% graph Lapacian
degrees = sum(A);

L = diag(degrees) - A;
if normalize
    invSqrtD = arrayfun(@(x) 1/sqrt(x), degrees );
    L = diag(invSqrtD) * L * diag(invSqrtD);
end

% calculate eigenvalues and eigenvectors
[V, E] = eig(L);
eigenvalues = diag(E);

[E, indices] = sort(eigenvalues, 'ascend');
V = V(:, indices);

% stats
Stats.max = max(E);
Stats.mean = mean(E);
Stats.median = median(E);
Stats.std = std(E);

end

