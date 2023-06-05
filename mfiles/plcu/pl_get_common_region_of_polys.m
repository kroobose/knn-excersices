%
% ret = pl_common_region_of_polys( poly1, poly2 )
% 
%  poly1 $B$*$h$S(B poly2 $B$NFLB?3Q7A$ND:E@$H$7!$(B
%  $B6&DLNN0h$OFLB?3Q7A$H$J$k!%$=$ND:E@$rJV$9!%(B
%
%  $B%"%k%4%j%:%`$O<+:n!%0J2<!%(B
%  (1) $B6&DLNN0h$ND:E@(B ret $B$rNs5s!%(B
%      $BD:E@$H$J$k>r7o$O0J2<$N$I$l$+!%(B
%      $B!&(B poly1 $B$ND:E@$G(B poly2 $B$NFbIt!%(B
%      $B!&(B poly2 $B$ND:E@$G(B poly1 $B$NFbIt!%(B
%      $B!&(B poly1 $B$NJU$H(B poly2 $B$NJU$N8rE@!%(B
%  (2) $B6&DLNN0h$ND:E@(B ret $B$N=E?4$r5a$a$k!%(B
%  (3) $B6&DLNN0h$N3FD:E@$N=E?4$+$i$_$?3QEY$rD4$Y$k!%(B
%  (4) $B6&DLNN0h$N3FD:E@$r3QEY$G%=!<%H!%(B
%  (5) $B=EJ#D:E@$r:o=|!%(B
% 
% 
function ret = pl_get_common_region_of_polys( poly1, poly2 )

poly1 = pl_del_redundant_vertices(poly1);
poly2 = pl_del_redundant_vertices(poly2);
ndims = size(poly1,1);
npts1 = size(poly1,2);
npts2 = size(poly2,2);

%  (1) $B6&DLNN0h$ND:E@(B ret $B$rNs5s!%(B
ret = zeros(2,0);
%      $BD:E@$H$J$k>r7o$O0J2<$N$I$l$+!%(B
%      $B!&(B poly1 $B$ND:E@$G(B poly2 $B$NFbIt!%(B
for i=1:npts1
  if pl_is_in_poly( poly1(:,i), poly2 )
    ret = [ret, poly1(:,i) ];
  end
end
%      $B!&(B poly2 $B$ND:E@$G(B poly1 $B$NFbIt!%(B
for i=1:npts2
  if pl_is_in_poly( poly2(:,i), poly1 )
    ret = [ret, poly2(:,i) ];
  end
end
%      $B!&(B poly1 $B$NJU$H(B poly2 $B$NJU$N8rE@!%(B
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

%  (2) $B6&DLNN0h$ND:E@(B ret $B$N=E?4$r5a$a$k!%(B
g  = rmean(ret);
%  (3) $B6&DLNN0h$N3FD:E@$N=E?4$+$i$_$?3QEY$rD4$Y$k!%(B
th = atan2( ret(2,:) - g(2), ret(1,:) - g(1) );
%  (4) $B6&DLNN0h$N3FD:E@$r3QEY$G%=!<%H!%(B
[tmp,r_tmp] = sort(th);
ret = ret(:,r_tmp);
%  (5) $B=EJ#D:E@$r:o=|!%(B
ret = pl_del_redundant_vertices(ret);

