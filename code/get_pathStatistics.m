% get_pathStatistics.m 
% 
% The script pathStatistics.m gives the folllowing 
%       average path length 
%       maxim   path length 
%       histogram of all path length 
% 
% Need the data file 
%       AgapCherm.mat, 
% which can be created by excuting 
%       parse_gapMatrix_hermC.m 
% 

close all 
% clear all 

figureCount = 1;  


% .. load data by parse_gapMatrix_hermC.m 

%load( 'AgapCherm.mat' ) ; % contains AgapChermSparse, nodeLabel  
% load('herm_adj_remove_hub.mat');
load('herm_adj');
A = (AGap + AChem);

%% Use Bioinformatics Toolbox for graph computations
%
% Path Length
%

% ... generate the electric junction graph

% Ggap   = biograph( AgapChermSparse, nodeLabel );

Agap01 = (A > 0);       % binary-valued adjacency matrix 
Ggap01 = biograph(Agap01, nodeLabel); % graph with unweighted edges 

% view graph                          % slow 




% ... all shortest paths : unweighted 

Ggap01pathlengths = graphallshortestpaths( Agap01 );



% ... choose paths of finite and non-zero length 

pathIndex  = find( isfinite(Ggap01pathlengths) & (Ggap01pathlengths ~= 0) );
Ggap01pathEffective = Ggap01pathlengths( pathIndex ); 

Ggap01pathMean = mean( Ggap01pathEffective ); 
Ggap01pathMax  = max( Ggap01pathEffective ); 

disp( ' ' ) ;

Bstring = ' path length for electric junction network:'; 
disp( [ ' Avg', Bstring, sprintf( ' %d ', Ggap01pathMean ) ] ) ;
disp( [ ' Max', Bstring, sprintf( ' %d \n', Ggap01pathMax  ) ] ) ;


% ... display path matrix and path histogram  

figure( figureCount ); 
figureCount = figureCount + 1;

imagesc( Ggap01pathlengths ) ; 
axis equal 
colorbar 
axis off 
title( 'The path length matrix' ); 
colormap gray

figure( figureCount ); 
figureCount = figureCount + 1;

hist( Ggap01pathEffective, Ggap01pathMax +1) ; 
title('Histogram of Path Length for Herm Gap Junction Network');
xlabel('Path Length');
ylabel('Number of Paths per Bin'); 


% ... comments during the code development 

disp( ' ' ); 
disp( ' Try to do sth and get rid of any warning ; ' ); 
disp( ' Pay particular attention to the blue submatrices ... ' ) ;
disp( ' It is possible to reorder them ; ' ); 
disp( ' There are paths of infinite length : do sth about it ... ' ); 
disp( ' Once done, turn it into a function ' ); 
disp( ' ' ); 

return 

% ----------------------------------------------------------
% Initially created by 
% Rex Ying 
% May 2013 
% 
% Edited by 
% Xiaobai Sun and Aleandros 
% June 2013 
% 
% Department of Computer Science, Duke University 
%-------------------------------------------------------------
