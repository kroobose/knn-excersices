%
% ret = pl_shift_affmat( th )
%
function ret = pl_shift_affmat( t )

ret = eye(3);
ret([1,2],3) = t;



