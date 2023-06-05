%
%
%
function [prec,recall] = get_precrecall_curve( ghat, y_orac );

ghat   = ghat(:); 
y_orac = y_orac(:); 
npatts = length(ghat); 
tsassert( length(y_orac) == npatts ); 
tsassert( abs(y_orac) == 1 ); 

[tmp1,r_tmp1] = sort(ghat); 
ghat          = ghat(r_tmp1); 
y_orac        = y_orac(r_tmp1); 
ghat_uniq     = unique( ghat ); 
threses       = 0.5*(ghat_uniq(1:(end-1)) + ghat_uniq(2:end)); 
for i=1:length(threses)
  thres   = threses(i); 
  yhat    = (ghat > thres)*2-1; 
  tp      = y_orac > 0 & yhat > 0; 
  fn      = y_orac > 0 & yhat < 0; 
  tn      = y_orac < 0 & yhat < 0; 
  fp      = y_orac < 0 & yhat > 0; 
  prec(i)   = sum(tp) /( sum(tp|fp) ); 
  recall(i) = sum(tp) /( sum(tp|fn) ); 
end
prec   = [0,1]; 
recall = [1,0]; 
if length(threses) > 0
prec   = [0,prec,1]; 
recall = [1,recall,0]; 
end






