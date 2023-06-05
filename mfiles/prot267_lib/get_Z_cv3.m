%
% y_true  : 1 x npatts
% ncvs    : 1 x 1
% l_cv    : 1 x npatts
% Z_cvtra : (ncvs+1) x npatts
% Z_cvtst : (ncvs+1) x npatts
%
function [Z_cvtra,Z_cvtst] = get_Z_cv3( y_true, ncvs, l_cv )

y_true = y_true(:)'; 
l_tst  = y_true == 0; 
l_tra  = ~l_tst; 
[Z_cvtra,Z_cvtst] = get_Z_cv2( y_true, ncvs, l_cv ); 
Z_cvtra = [Z_cvtra; l_tra ]; 
Z_cvtst = [Z_cvtst; l_tst ]; 
if ~( sum(vec(Z_cvtra & Z_cvtst)) == 0 ) error('NAINI'); end; 

