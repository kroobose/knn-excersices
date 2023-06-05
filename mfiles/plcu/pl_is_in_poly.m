%
% ret = pl_is_in_poly( x, poly )
%
% poly は凸多角形と仮定．
%
function ret = pl_is_in_poly( x, poly1 )

ndims = size(poly1,1);
npts  = size(poly1,2);

if ~( ndims   == 2 ), error('NANIIINII1'); end;
if ~( size(x) == [2,1] ), error('NANIIINII2'); end;
poly2 = poly1(:,end:-1:1);

if pl_is_clockwise( poly1 )
  ret = 1;
  for i0=1:npts
    i1 = mod( i0+1-1, npts ) + 1;
    ret = ret & pl_area( [poly1(:,[i0,i1]),x] ) <= 0;
  end
elseif pl_is_clockwise( ~poly2 )
  ret = 1;
  for i0=1:npts
    i1 = mod( i0+1-1, npts ) + 1;
    ret = ret & pl_area( [poly2(:,[i0,i1]),x] ) <= 0;
  end
else
  error('NAINIININI');
end


