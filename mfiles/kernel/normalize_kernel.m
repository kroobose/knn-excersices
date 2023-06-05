function Kn = normalize_kernel(K)

% Normalizing the kernel
d    = sqrt(diag(K));
l    = d > 0;
d(l) = 1./d(l);
% Kn = diag(d)*K*diag(d);
Kn = cprod(rprod(K,d),d');

