%
%
%
function [Xe,Ve] = get_Xe_tratst( kernmat )

ntras  = size(kernmat,1);
npatts = size(kernmat,2);

[V,D]  = eig(kernmat(:,1:ntras));
eivals = diag(D);
l_tmp1 = eivals >= 1e-6;
V      = V(:,l_tmp1); eivals = eivals(l_tmp1);
% Xe     = cprod(V,sqrt(eivals'))';
Ve     = rprod(V',1./sqrt(eivals)); 
Xe     = Ve*kernmat; 


