%
% ret = pl_rot_affmat( th )
%
function ret = pl_rot_affmat( th )

ret = eye(3);
ret([1,2],[1,2]) = [ cos(th),-sin(th); sin(th), cos(th) ];

