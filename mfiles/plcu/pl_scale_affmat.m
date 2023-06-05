%
% ret = pl_scale_affmat( s )
%
function ret = pl_scale_affmat( s )

ret  = eye(3);
lmat = logical(eye(3)); lmat(3,3) = 0;
ret(lmat) = s;





