function [xAxis, percentAxis ] = survivalfunction( distribution )
%
% Compute survival function of a distribution (complementsvn of a cumulative
% distribution function)
%
% SYNTAX
%
%   [xAxis, percentAxis] = survivalfunction( dist )
%
% INPUT
%
%   distribution         [N-by-1] (N = number of data entries)
%
% OUTPUT
%
%   xAxis                [N-by-1]
%                        from 1 to max(distribution)
%   percentAxis          [N-by-1]
%                        percentAxis(i) = percentage of entries that are 
%                        bigger than xAxis(i)
%
%
% DESCRIPTION
%
% The advantages of looking at the survival function
% rather than the degree distribution directly are that histogram
% binning is not required and that noise in the tail is reduced 
% ([1] page 4)
%
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
% [1] Lav R. Varshney, Beth L. Chen, Eric Paniagua, David H. Hall, and Dmitri B. Chklovskii.
% Structural properties of the Caenorhabditis elegans neuronal network. PLoS Computa-
% tional Biology, 7(2):e1001066, February 2011.
%
%
% AUTHOR
%
%   Rex Ying       zy26@cs.duke.edu
%


% --------------------------------------------------------------------

distribution = sort(distribution, 'descend');

%xAxis = 1: distribution(1); % in descending order (first one is max)
xAxis = unique(distribution);
nEntries = size(xAxis, 1);
percentAxis = zeros(nEntries);
survivalCount = size(distribution, 1);
 
current = xAxis(nEntries); % starts at the smallest
iAxis = 1;

while survivalCount >= 1
    while ( (survivalCount >= 1) && (current == distribution(survivalCount)) )
        survivalCount = survivalCount - 1;
    end
    if (survivalCount < 1) % no survivor
        break;
    end
    current = distribution(survivalCount);
    percentAxis(iAxis) = double(survivalCount) / nEntries;
    iAxis = iAxis + 1;
end


return 
