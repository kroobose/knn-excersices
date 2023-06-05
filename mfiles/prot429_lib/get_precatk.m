function precs = get_precatk( ghat_tst, y_tst, ks )
%
% precs = get_precatk( ghat_tst, y_tst, ks )
%

ghat_tst = full(ghat_tst(:));
y_tst    = full(y_tst(:));
ntsts    = numel(y_tst); 
tsassert( numel(ghat_tst) == ntsts ); 

[tmp1,r_tmp1] = sort(-ghat_tst); 
ghat_tst      = ghat_tst(r_tmp1); 
y_tst         = y_tst(r_tmp1); 

for i_k=1:numel(ks)
  k = ks(i_k); 
  tp = sum(y_tst(1:k) > 0); 
  fp = sum(y_tst(1:k) < 0); 
  fn = sum(y_tst(k+1:end) > 0); 
  prec = tp/(tp+fp); 
  precs(i_k) = prec; 
end

