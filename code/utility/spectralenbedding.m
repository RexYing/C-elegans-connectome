function [ ] = spectralenbedding( A, eigenvectors, eigenvalues, dim )
%
% Spectral embedding in 1, 2, or 3 dimensions
%
% SYNTAX
%
%   spectralenbedding(adjMat, eivenvectors, eigenvalues, 2:2:6)
%
% INPUT
%
%   A                   [N-by-N] adjacency matrix
%   eigenvectors        [N-by-N] matrix 
%                       Eigenvectors of graph Laplacian
%   eigenvalues         [N-by-1] matrix
%                       Eigenvalues of graph Laplacian
%   dim                 The index of eigenvectors as axis(axes)
%
% OUTPUT
%
%
% DESCRIPTION
%
% Spectral methods use selected eigenvectors of a data affinity matrix to 
% obtain a data representation that can be trivially clustered or embedded 
% in a low-dimensional space. 
%
% ALGORITHM
%
% Plot...
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
%   Xiaobai Sun    xiaobai@cs.duke.edu
%   Rex Ying       zy26@cs.duke.edu
%


% --------------------------------------------------------------------

if size(dim, 1) < 1
    disp('empty dimension');
    return;
end

X    = eigenvectors(:, dim) ; 
X    = X * diag(sqrt( eigenvalues(dim) ) );            % axial scaling 

%% ... 1D spectrai embedding

dispMsg = sprintf('\n Press a key for 1D spectral embedding \n' );            
disp( dispMsg ) ; 
pause 


figure
plot( 1: size(A, 1), X(:,1), 'm.'); 
grid on 
dispMsg = sprintf( ' embedding vector = %d\n', dim(1) );
title( [ '1D node clustering with', dispMsg ]  ); 

if length(dim) == 1
    return
end


%% ... 2D spectrai embedding 

dispMsg = sprintf('\n Press a key for 2D spectral embedding \n' );            
disp( dispMsg ) ; 
pause 

figure
plot( X(:,1), X(:,2), 'm.'); 
grid on 
dispMsg = sprintf( ' embedding vectors = [%d, %d]\n', dim(1), dim(2));
title( [ '2D node clustering with', dispMsg ]  ); 


figure
plot( X(:,1), X(:,2), 'm.'); 
hold on 
gplot( A, X(:,1:2) );
grid on 
title('2D spectral embedding of Agap'); 

if length(dim) == 2
    return
end

%% ... 3D spectrai embedding  

dispMsg = sprintf('\n Press a key for 3D spectral embedding \n' );            
disp( dispMsg ) ; 
pause 


figure
plot3( X(:,1), X(:,2), X(:,3), 'm.'); 
xlabel( 'dimension 1') 
grid on; box on ; 
rotate3d 

dispMsg = sprintf( ' embedding vectors = [%d, %d, %d]\n', dim(1), ...
                   dim(2), dim(3) );
title( [ '3D node clustering with', dispMsg ]  ); 


h = figure ; 
plot3( X(:,1), X(:,2), X(:,3), 'm.'); 
xlabel( 'dimension 1') 
hold on 
gplot3D( A, X(:,1:3) );
title('3D spectral embedding of Agap');
grid on 
box on 
rotate3d 

dispMsg = sprintf( ' You may rotate 3D Figures \n '  ); 
disp( dispMsg ) 

return 

end

