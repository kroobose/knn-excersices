%
% Wilcoxon Signed Rank Test
% 
% Bernard Rosner: Fundamentals of Biostatistics, p.338--
% 
function pval = do_wilcoxon_sgnrank( ds_orig )

ds     = ds_orig; 
ds     = ds( ds ~= 0 ); 
n      = length(ds); 
if n == 0,
  pval = 1.0; return;
end
ds_abs = abs(ds); 
ds_sgn = sign(ds);
tmp2   = ds_abs; 
ranks  = zeros(1,n); 
r_cur  = 0; 
ts     = []; 
while length(tmp2) > 0
  di     = min(tmp2); 
  l_tmp2 = ( ds_abs == di ); 
  n_tmp1 = sum(l_tmp2); 
  r_tmp1 = r_cur + (1:n_tmp1); 
  ranks(l_tmp2) = mean(r_tmp1); 
  tmp2   = tmp2( tmp2 > di ); 
  r_cur  = max(r_tmp1); 
  ts     = [ ts, sum(l_tmp2) ]; 
end

l_pos  = ds_sgn == +1; 
R1     = sum(ranks(l_pos)); 
E_R1   = n*(n+1)/4; 
Var_R1 = n*(n+1)*(2*n+1)/24  - sum(ts.*ts.*ts - ts)/48; 
sd_R1  = sqrt(Var_R1); 
tval   = (abs(R1-E_R1)-0.5)/sd_R1;
pval   = 2*(1-normcdf(tval)); 



