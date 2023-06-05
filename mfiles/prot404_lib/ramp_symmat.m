function ret = ramp_symmat( A )

A     = 0.5*(A+A'); 
[U,D] = eig(A); 
ret   = U*max(D,0)*U'; 


