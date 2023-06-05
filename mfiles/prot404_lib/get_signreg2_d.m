function [ret,W] = get_signreg2_d(V,l_sgn) 
%
% This function get_signreg_p(W,lam2) computes
% the convex conjugate of the sign regularizer 
% 
%   get_signreg2_p(V,l_sgn) 
%
% for each column in V. 
%

nfeas = size(V,1); 
if nargin >= 2,
  tsassert( islogical( l_sgn ) ); 
  tsassert( numel(l_sgn) == nfeas ); 
else
  l_sgn = true(nfeas,1); 
end
W          = V; 
W(l_sgn,:) = max(W(l_sgn,:),0); 
ret   = 0.5*csum(W.^2); 

