function ret = get_numederiv1( x, fh, epsi )
%
% Numerical differentiation
%

if nargin == 2,
  epsi  = 1e-4; 
end

nfeas = numel(x); 
ret   = zeros(size(x));
for i_fea=1:nfeas
  x1 = x; x2 = x; 
  x1(i_fea) = x1(i_fea) - epsi*0.5;  
  x2(i_fea) = x2(i_fea) + epsi*0.5;  
  ret(i_fea) = (fh(x2)-fh(x1))/epsi; 
end

