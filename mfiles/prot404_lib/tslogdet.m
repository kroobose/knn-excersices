function ret = tslogdet( X ) 
%
%
%

nrows = size(X,1); 
ncols = size(X,1); 
tsassert( nrows == ncols ); 

[U,D,V] = svd(X); 
ds = diag(D); 
ret = sum(log(ds)); 
