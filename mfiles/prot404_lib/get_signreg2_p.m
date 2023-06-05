function ret = get_signreg2_p(W,l_sgn) 
%
% This function get_signreg_p(W,lam2) computes
% the sign regularizer (named by TK) which is
% defined as follows. 
% 
% The value is  
%   (1/2)*lam1*w_{i}.^2 
%
% when all entries given signed constraints
% are non-negagive.  Otherwise, the value is 
%
%   +infinity. 
%
% This function computes the value of the regularizer
% for each column in W. 
%

nfeas = size(W,1); 
if nargin >= 2,
  tsassert( islogical( l_sgn ) ); 
  tsassert( numel(l_sgn) == nfeas ); 
else
  l_sgn = true(nfeas,1); 
end
l_fre = ~l_sgn; 
% W_fre = W(l_fre,:); 
W_sgn = W(l_sgn,:); 
l_vio = csum(W_sgn < 0) > 0; 
term1 = 0.5.*csum(W.^2); 
term2 = l_vio * 1e+300; 
ret   = term1 + term2; 





