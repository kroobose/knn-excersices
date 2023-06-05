%
% ret = pl_is_conv( poly )
%
function ret = pl_is_conv( poly1 )

ndims = size(poly1,1);
npts  = size(poly1,2);
if ~( ndims   == 2 ), error('NANIIINII'); end;
if ~( size(x) == [2,1] ), error('NANIIINII'); end;
poly2 = poly1(:,end:-1:1);

ret = pl_is_clockwise( poly1 ) |pl_is_clockwise( poly2 );


