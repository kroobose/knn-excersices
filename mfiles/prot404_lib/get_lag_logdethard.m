function [obj_dual,res] = get_lag_logdethard( A, alph, iA0, Xtil, y_tra, bds )
%
% D(A,A0) 
% + \sum_k alph(k) * ( y_tra(k)*(<a(k),A*a(k)> - bds(k)) )
%
% where
% 
%  a(k) = Xtil(:,k). 
%

if numel(A) == 0, 
  B_cur = mtimes_diag( Xtil, alph.*y_tra )*Xtil'; 
  A = inv(iA0+B_cur); 
end

dists = csum( Xtil.*(A*Xtil) )'; 
term1    = get_logdetdiv( A, [], iA0 ); 
us       = y_tra(:).*(dists-bds); 
term2    = sum(alph.*us); 
obj_dual = term1+term2; 

res.dists = dists; 
res.term1 = term1; 
res.us    = us; 
res.term2 = term2; 

