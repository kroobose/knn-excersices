function ret = rminus( A, b )
%
%
%
b = b(:)'; 
[nrows,ncols] = size(A); 
tsassert( size(b) == [1,ncols] ); 
ret = A-(ones(nrows,1)*b); 

