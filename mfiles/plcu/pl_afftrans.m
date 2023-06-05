%
%
%
function ret = pl_afftrans( T, X )

ndims = size(X,1);
npts  = size(X,2);
if ~( ndims == 2 ) error('NIANIIINII'); end;
if ~( size(T)==[3,3] ) error('NAINIINIIINI'); end;

ret = T(1:2,1:2) * X + T(:,3)*ones(1,npts);


