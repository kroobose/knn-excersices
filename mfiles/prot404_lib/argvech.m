function X = argvech( x )
%
%
%

x = x(:); 
d = numel(x); 
n = (-1+sqrt(1+8*d))/2; 

lmat = tril(ones(n)) > 0; 
X = zeros(n); 
X(lmat) = x; 
X = X+X'-diag(diag(X)); 


