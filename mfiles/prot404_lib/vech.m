function x = vech( X )
%
%
%

nrows = size(X,1); 
ncols = size(X,1); 
tsassert( size(X) == [nrows,ncols] ); 

lmat = tril(ones(nrows)) > 0; 
x = X(lmat); 


