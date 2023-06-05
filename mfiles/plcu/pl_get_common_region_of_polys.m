%
% ret = pl_common_region_of_polys( poly1, poly2 )
% 
%  poly1 および poly2 の凸多角形の頂点とし，
%  共通領域は凸多角形となる．その頂点を返す．
%
%  アルゴリズムは自作．以下．
%  (1) 共通領域の頂点 ret を列挙．
%      頂点となる条件は以下のどれか．
%      ・ poly1 の頂点で poly2 の内部．
%      ・ poly2 の頂点で poly1 の内部．
%      ・ poly1 の辺と poly2 の辺の交点．
%  (2) 共通領域の頂点 ret の重心を求める．
%  (3) 共通領域の各頂点の重心からみた角度を調べる．
%  (4) 共通領域の各頂点を角度でソート．
%  (5) 重複頂点を削除．
% 
% 
function ret = pl_get_common_region_of_polys( poly1, poly2 )

poly1 = pl_del_redundant_vertices(poly1);
poly2 = pl_del_redundant_vertices(poly2);
ndims = size(poly1,1);
npts1 = size(poly1,2);
npts2 = size(poly2,2);

%  (1) 共通領域の頂点 ret を列挙．
ret = zeros(2,0);
%      頂点となる条件は以下のどれか．
%      ・ poly1 の頂点で poly2 の内部．
for i=1:npts1
  if pl_is_in_poly( poly1(:,i), poly2 )
    ret = [ret, poly1(:,i) ];
  end
end
%      ・ poly2 の頂点で poly1 の内部．
for i=1:npts2
  if pl_is_in_poly( poly2(:,i), poly1 )
    ret = [ret, poly2(:,i) ];
  end
end
%      ・ poly1 の辺と poly2 の辺の交点．
for i1_0=1:npts1
  for i2_0=1:npts2
    i1_1 = mod(i1_0+1-1,npts1)+1;
    i2_1 = mod(i2_0+1-1,npts2)+1;
    [crossing,pt] = pl_is_crossing( poly1(:,[i1_0,i1_1]), poly2(:,[i2_0,i2_1]) );
    if crossing,
      ret = [ ret, pt ];
    end
  end
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

