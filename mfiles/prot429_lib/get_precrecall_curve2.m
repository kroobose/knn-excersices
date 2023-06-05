function curve = get_precrecall_curve2( ghat_tst, y_tst )
%
% curve = get_precrecall_curve( ghat_tst, y_tst )
%

ghat_tst = ghat_tst(:); 
y_tst    = y_tst(:); 
ntsts    = numel(y_tst); 
nps      = sum(y_tst>0); 
tsassert( numel(y_tst)    == ntsts ); 
tsassert( numel(ghat_tst) == ntsts ); 

[tmp1,r_tmp1] = sort(-ghat_tst); 
ghat_tst      = ghat_tst(r_tmp1); 
y_tst         = y_tst(r_tmp1); 

r_p           = find(y_tst(:)' > 0); 

precs   = (1:nps)./r_p; 
recalls = (1:nps)./nps; 

curve = [0,recalls,1;1,precs,0]; 

