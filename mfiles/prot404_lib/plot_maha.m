function plt = plot_maha( A_orac, sty )

tsassert( isreal(A_orac) ); 
A_orac = 0.5*(A_orac+A_orac'); 
[U,Lam]=eig(A_orac); 
tsassert( isreal(U) ); 
tsassert( isreal(Lam) ); 
lam    = diag(Lam); 
tmp1   = (0:72)/72*(2*pi); 
Y_tmp1 = [cos(tmp1);sin(tmp1)]; 
X_circ = U*diag(1./(sqrt(lam)+1e-16))*Y_tmp1; 
plt = plot( X_circ(1,:), X_circ(2,:), 'k-' ); 
