%
%
%
function ret = get_rocx( ghat, y_orac )

[fp,tp]=calcroc( ghat, y_orac ); 

tsassert(issorted(fp)); 
% thres_fp = 0.1; 
thres_fp = 0.1; 
i_thres  = max(find( fp < thres_fp )); 

for i=1:i_thres
  s2(i) = (fp(i+1)-fp(i))*(tp(i)+tp(i+1))*0.5;
end
i1 = i_thres; 
i2 = i_thres + 1; 
ratio    = (thres_fp-fp(i1))/(fp(i2)-fp(i1)); 
thres_tp = tp(i1) + (tp(i2)-tp(i1))*ratio; 
s2(i_thres+1) = (thres_fp-fp(i1))*(thres_tp+tp(i1))*0.5; 

ret = sum(s2);

