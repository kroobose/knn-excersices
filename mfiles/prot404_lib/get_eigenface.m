function [U_fea,mu_fea] = get_eigenface( X_tra )
%
%
%

ntras = size(X_tra,2); 
X_tra = X_tra; 
mu_fea = rmean(X_tra); 
Xbar = X_tra - mu_fea*ones(1,ntras); 

K = Xbar'*Xbar; 
[V,S_pow] = eig(K); 
s = sqrt(max(diag(S_pow),1e-8)); 
[tmp1,r_srt] = sort(-s);
V = V(:,r_srt); s = s(r_srt); 
U_fea = Xbar*V*diag(1./s); 

