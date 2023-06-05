%
%
%
function [V,D] = ts_eig( A )

A     = 0.5*(A+A'); 
[V,D] = eig(A); 
d     = diag(D); 
[tmp1,r_srt] = sort(-d); 
d     = d(r_srt); 
D     = diag(d); 
V     = V(:,r_srt); 

