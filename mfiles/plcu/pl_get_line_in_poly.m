%
% ret = pl_get_line_in_poly( poly, w, b )
%
function ret = pl_get_line_in_poly( poly1, w, b )

poly1 = pl_del_redundant_vertices(poly1);
ndims = size(poly1,1);
npts1 = size(poly1,2);
if ~( ndims == 2 ), error('NAINIINIIINI1'); end;
if ~( size(w) == [ndims,1] ), error('NAINIINIIINI1'); end;
if ~( size(b) == [1,1] ), error('NAINIINIIINI1'); end;

ret = zeros(2,0);
for i0=1:npts1
  i1 = mod(i0+1-1,npts1)+1;
  [crossing,pt] = pl_is_crossing_with_infline( poly1(:,[i0,i1]), w, b );
  if crossing,
    ret = [ret, pt];
  end
end

