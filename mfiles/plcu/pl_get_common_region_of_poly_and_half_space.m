%
% ret = pl_get_common_region_of_poly_and_half_space( poly1, w, b )
%  
% 凸多角形 poly1 と半空間 dot(w,x)+b >= 0 との共通領域は
% 凸多角形になる．その頂点を返す．
%  (1) 共通領域の頂点 ret を列挙．
%      頂点となる条件は以下のどれか．
%      ・ poly1 の頂点で dot(w,x)+b >= 0 を満たす．
%      ・ poly1 と直線 dot(w,x)+b >= 0 との交点．
%  (2) 共通領域の頂点 ret の重心を求める．
%  (3) 共通領域の各頂点の重心からみた角度を調べる．
%  (4) 共通領域の各頂点を角度でソート．
%  (5) 重複頂点を削除．
%
function ret = pl_get_common_region_of_poly_and_half_space( poly1, w, b )

poly1 = pl_del_redundant_vertices(poly1);
ndims = size(poly1,1);
npts1 = size(poly1,2);
if ~( ndims == 2 ), error('NAINIINIIINI1'); end;
if ~( size(w) == [ndims,1] ), error('NAINIINIIINI1'); end;
if ~( size(b) == [1,1] ), error('NAINIINIIINI1'); end;

ret = zeros(2,0);
%  (1) 共通領域の頂点 ret を列挙．
%      頂点となる条件は以下のどれか．
%      ・ poly1 の頂点で dot(w,x)+b >= 0 を満たす．
for i0=1:npts1
  i1 = mod(i0+1-1,npts1)+1;
  [crossing,pt] = pl_is_crossing_with_infline( poly1(:,[i0,i1]), w, b );
  if crossing,
    ret = [ret, pt];
  end
end
%      ・ poly1 と直線 dot(w,x)+b >= 0 との交点．
for i0=1:npts1
  if dot(w,poly1(:,i0))+b >= 0,
    ret = [ret, poly1(:,i0)];
  end
end
if ~(size(ret,2) >= 3)
  ret = zeros(2,0); return;
end
%  (2) 共通領域の頂点 ret の重心を求める．
g  = rmean(ret);
%  (3) 共通領域の各頂点の重心からみた角度を調べる．
th = atan2( ret(2,:) - g(2), ret(1,:) - g(1) );
%  (4) 共通領域の各頂点を角度でソート．
[tmp,r_tmp] = sort(th);
ret = ret(:,r_tmp);
%  (5) 重複頂点を削除．
ret = pl_del_redundant_vertices(ret);
