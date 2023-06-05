%
% ret = pl_is_clockwise( poly )
%
function ret = pl_is_clockwise( poly )

ndims = size(poly,1);
npts  = size(poly,2);
if ~( ndims == 2 ), error('NANIIINII'); end;

ret = 1;
for i0=1:npts
  i1 = mod( i0+1-1, npts ) + 1;
  i2 = mod( i1+1-1, npts ) + 1;
  ret = ret & pl_area( poly(:,[i0,i1,i2]) ) <= 0;
end



