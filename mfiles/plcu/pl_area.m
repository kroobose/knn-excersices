%
%
%
function ret = pl_area(X)

ndims  = size(X,1);
npatts = size(X,2);
if ~(ndims == 2), error('NANIINII'); end;
if ~(npatts == 3), error('NANIINII'); end;

x1 = X(1,1); y1 = X(2,1);
x2 = X(1,2); y2 = X(2,2);
x3 = X(1,3); y3 = X(2,3);

ret = ( x1 - x3 ) * ( y2 - y3 ) + ( x2 - x3 ) * ( y3 - y1 );






