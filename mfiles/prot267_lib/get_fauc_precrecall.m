%
%
%
function fauc = get_fauc_precrecall( ghat, y_orac )

l_tst  = abs(y_orac) > 0;
ghat   = ghat(l_tst); 
y_orac = y_orac(l_tst); 

[prec,recall] = get_precrecall_curve( ghat, y_orac ); 
[tmp1,r_tmp1] = sort(recall); 
prec   = prec(r_tmp1); 
recall = recall(r_tmp1); 
s2 = zeros(length(prec)-1,1);
for i=1:length(s2)
  s2(i) = (recall(i+1)-recall(i))*(prec(i)+prec(i+1))*0.5;
end
fauc = sum(s2);



