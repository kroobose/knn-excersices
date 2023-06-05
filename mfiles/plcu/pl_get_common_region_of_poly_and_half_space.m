%
% ret = pl_get_common_region_of_poly_and_half_space( poly1, w, b )
%  
% $BFLB?3Q7A(B poly1 $B$HH>6u4V(B dot(w,x)+b >= 0 $B$H$N6&DLNN0h$O(B
% $BFLB?3Q7A$K$J$k!%$=$ND:E@$rJV$9!%(B
%  (1) $B6&DLNN0h$ND:E@(B ret $B$rNs5s!%(B
%      $BD:E@$H$J$k>r7o$O0J2<$N$I$l$+!%(B
%      $B!&(B poly1 $B$ND:E@$G(B dot(w,x)+b >= 0 $B$rK~$?$9!%(B
%      $B!&(B poly1 $B$HD>@~(B dot(w,x)+b >= 0 $B$H$N8rE@!%(B
%  (2) $B6&DLNN0h$ND:E@(B ret $B$N=E?4$r5a$a$k!%(B
%  (3) $B6&DLNN0h$N3FD:E@$N=E?4$+$i$_$?3QEY$rD4$Y$k!%(B
%  (4) $B6&DLNN0h$N3FD:E@$r3QEY$G%=!<%H!%(B
%  (5) $B=EJ#D:E@$r:o=|!%(B
%
function ret = pl_get_common_region_of_poly_and_half_space( poly1, w, b )

poly1 = pl_del_redundant_vertices(poly1);
ndims = size(poly1,1);
npts1 = size(poly1,2);
if ~( ndims == 2 ), error('NAINIINIIINI1'); end;
if ~( size(w) == [ndims,1] ), error('NAINIINIIINI1'); end;
if ~( size(b) == [1,1] ), error('NAINIINIIINI1'); end;

ret = zeros(2,0);
%  (1) $B6&DLNN0h$ND:E@(B ret $B$rNs5s!%(B
%      $BD:E@$H$J$k>r7o$O0J2<$N$I$l$+!%(B
%      $B!&(B poly1 $B$ND:E@$G(B dot(w,x)+b >= 0 $B$rK~$?$9!%(B
for i0=1:npts1
  i1 = mod(i0+1-1,npts1)+1;
  [crossing,pt] = pl_is_crossing_with_infline( poly1(:,[i0,i1]), w, b );
  if crossing,
    ret = [ret, pt];
  end
end
%      $B!&(B poly1 $B$HD>@~(B dot(w,x)+b >= 0 $B$H$N8rE@!%(B
for i0=1:npts1
  if dot(w,poly1(:,i0))+b >= 0,
    ret = [ret, poly1(:,i0)];
  end
end
if ~(size(ret,2) >= 3)
  ret = zeros(2,0); return;
end
%  (2) $B6&DLNN0h$ND:E@(B ret $B$N=E?4$r5a$a$k!%(B
g  = rmean(ret);
%  (3) $B6&DLNN0h$N3FD:E@$N=E?4$+$i$_$?3QEY$rD4$Y$k!%(B
th = atan2( ret(2,:) - g(2), ret(1,:) - g(1) );
%  (4) $B6&DLNN0h$N3FD:E@$r3QEY$G%=!<%H!%(B
[tmp,r_tmp] = sort(th);
ret = ret(:,r_tmp);
%  (5) $B=EJ#D:E@$r:o=|!%(B
ret = pl_del_redundant_vertices(ret);
