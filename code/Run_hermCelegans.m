% run_hermCelegans.m 
% 
% script 
% 
% for the initial study of encoded information with spectral analysis 
% of the Laplace matrix (for the undirected graph for now) 
% 
%   -- geometric embedding (node locations) 
%   -- clusters  
%   -- cluster labeling 
% 
% Data from http://www.wormatlas.org/neuronalwiring.html
% under 2 Neuronal Connectivity II: by L.R. Varshney, B.L. Chen, E. Paniagua, D.H. Hall and D.B. Chklovskii
% Section 2.1 Connectivity Data (excel file)
% 

clear all
close all

% ... load data matrices A

load( 'herm_connectomes.mat' );   % downloaded by Nikolaos S.
                                  % without source recorded, unfortunately
                                  
% ... display loaded adjacency matrices 

figure 
spy( Achem )
title(' Adjacency matrix named Achem '  )  

dsymm = norm( Achem-Achem', 'fro');     % a measure for non-symmetry 
dispMsg = sprintf( ' non-symmetry component in F-norm = %g ', dsymm ); 
xlabel( dispMsg ) 

figure
spy(Agap)
title( ' Adjacency matrix named Agap '  ) 

dsymm = norm( Agap-Agap', 'fro');       % measure for non-symmetry 
dispMsg = sprintf( ' non-symmetry component in F-norm = %g ', dsymm ); 
xlabel( dispMsg ) 




% ... processing the Agap matrix, which is symmetric 

N       = size( Agap, 1 ) ; 
dispMsg = sprintf( ' Number of neurons included = %d ', N ); 
disp( dispMsg ) ;           % need to study the near decoupling 
                            
D    = sum( Agap, 2);       %  get the node degree distribution                 
Lgap = diag(D) - Agap;      %  form the Laplacian matrix  

[U, E] = eig( full( Lgap ) );  %  get the eigenvalue decomposition 
E  = diag(E);                  %  change the storage format to vector 
[E, Pindx] = sort( abs(E), 'descend');  % sorting in the eigenvales 
U  = U(:,Pindx);                        % permuting the eigenvectors 

% ... display spectral components  

figure 

subplot(3,1,1) 
plot( D, 'm.-'  ) ; 
title ('degree distribution' ); 

subplot(3,1,2) 
plot( E, 'b.-'  )
title( 'the eigenvalues of the Laplacian ' ) 

subplot(3,1,3) 
semilogy( abs(E), 'b.-'  )
title( 'the singular values of the Laplacian, log scale ' )


Lzeros = sum( ( E < sqrt( eps ) ) ) ;            % find numerical zeros 
dispMsg = sprintf( ' Number of numerical zero eigenvalues = %d \n ', Lzeros); 
disp( dispMsg ) ; 


figure 
imagesc( U(:, N-Lzeros+[1:Lzeros]) )
title( 'the eigenvectors at the low spectral end' ) 
colorbar 





% ------------------------------------------------------------------
%  ... spectral embedding of the graph 
% ------------------------------------------------------------------

spectral_range = 'small_spread'; 

switch spectral_range          % select an embedding subspace
    case 'small_spread' 
      k    = input( ' Enter spectral step size [1,80]  = ' ); 
      dispMsg = sprintf( '\n small spread within clusters \n ' ); 
      inds = 2: k: 3*k ; 

            % start with the highest spectral vector for clustering 
            % observation with the specific data 
            % k = 1,  see 5 clusters in a bilateral shape 
            % k = 2,  see 5 clusers with a rotation 
            % k = 10, four of the clusters form a base 
            % k = 70, four of the clusters form a cross-base 
  
  case 'large_spread' 
     k    = input( ' Enter spectral step size [1,9]  = ' ); 
     inds = (N-Lzeros) - [0:k:3*k];     
            % more spread at the low-end of the spectrum 
     dispMsg = sprintf( '\n Large spread within clusters \n ' );             
  
  otherwise 
     error( ' unknown embedding case  ' ); 
end

disp( dispMsg ) ; 
% Note : there are many other ways to select the embedding vectors 


% ... get the chosen eigenvectors 

X    = U(:, inds) ; 
X    = X *diag( sqrt( E(inds) ) ) ;            % axial scaling 

% ... 1D spectrai embedding 

dispMsg = sprintf('\n Press a key for 1D spectral embedding \n' );            
disp( dispMsg ) ; 
pause 


figure
plot( 1:N, X(:,1), 'm.'); 
grid on 
dispMsg = sprintf( ' embedding vector = %d\n', inds(1) );
title( [ '1D node clustering with', dispMsg ]  ); 


% ... 2D spectrai embedding 

dispMsg = sprintf('\n Press a key for 2D spectral embedding \n' );            
disp( dispMsg ) ; 
pause 

figure
plot( X(:,1), X(:,2), 'm.'); 
grid on 
dispMsg = sprintf( ' embedding vectors = [%d, %d]\n', inds(1), inds(2));
title( [ '2D node clustering with', dispMsg ]  ); 


figure
plot( X(:,1), X(:,2), 'm.'); 
hold on 
gplot( Agap, X(:,1:2) );
grid on 
title('2D spectral embedding of Agap'); 


% ... 3D spectrai embedding  

dispMsg = sprintf('\n Press a key for 3D spectral embedding \n' );            
disp( dispMsg ) ; 
pause 


figure
plot3( X(:,1), X(:,2), X(:,3), 'm.'); 
xlabel( 'dimension 1') 
grid on; box on ; 
rotate3d 

dispMsg = sprintf( ' embedding vectors = [%d, %d, %d]\n', inds(1), ...
                   inds(2), inds(3) );
title( [ '3D node clustering with', dispMsg ]  ); 


h = figure ; 
plot3( X(:,1), X(:,2), X(:,3), 'm.'); 
xlabel( 'dimension 1') 
hold on 
gplot3D( Agap, X(:,1:3) );
title('3D spectral embedding of Agap');
grid on 
box on 
rotate3d 

dispMsg = sprintf( ' You may rotate 3D Figures \n '  ); 
disp( dispMsg ) 

return 

%-------------------------------------
% Rex Ying, Xiaobai Sun
% Department of Computer Science 
% Duke University 
% -------------------------------------
