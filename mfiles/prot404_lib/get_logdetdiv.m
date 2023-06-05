function ret = get_logdetdiv( X, Y, iY )
%
%
%

nrows = size(X,1); 
ncols = size(X,2); 
if nargin == 2, 
  iY = inv(Y);
end
tsassert( nrows == ncols ); 
tsassert( size(iY) == size(X) ); 

term1 = dot(X(:),iY(:)); 
term2 = -tslogdet(X*iY); 
term3 = -nrows; 
ret = term1+term2+term3; 

