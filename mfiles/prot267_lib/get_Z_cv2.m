%
%
%
function [Z_cvtra,Z_cvtst] = get_Z_cv2( y_true, ncvs, l_cv )

y_true = y_true(:)'; 
npatts = length( y_true ); 
nps    = sum( y_true.*l_cv > 0 ); 
nns    = sum( y_true.*l_cv < 0 ); 
r_p    = find( y_true.*l_cv > 0 );
r_n    = find( y_true.*l_cv < 0 );
l_tst  = y_true == 0; 
l_tra  = ~l_tst; 
l_tra_noncv = l_tra & ~l_cv; 
r_tra_noncv = find(l_tra_noncv); 
if ( nps > 0 & nns > 0 )
  Z_cvtra = false( ncvs, npatts ); 
  Z_cvtst = false( ncvs, npatts ); 
  for cv=1:ncvs
    r_tmp1  = find(mod((1:nps)-1,ncvs)+1 ~= cv); 
    if ( length(r_tmp1) == 0 ) r_tmp1 = 1; end;
    r_p_cv  = r_p(r_tmp1); 
    r_tmp1  = find(mod((1:nns)-1,ncvs)+1 ~= cv); 
    if ( length(r_tmp1) == 0 ) r_tmp1 = 1; end;
    r_n_cv  = r_n(r_tmp1); 
    r_cvtra = [r_p_cv,r_n_cv,r_tra_noncv];
    l_cvtra = false(1,npatts); l_cvtra(r_cvtra) = 1; 
    l_cvtst = l_tra & ~l_cvtra; 
    Z_cvtra(cv,:) = l_cvtra; 
    Z_cvtst(cv,:) = l_cvtst; 
    if ~( sum( l_tst & l_cvtra ) == 0 ) error('NIANI'); end;
    if ~( sum( l_tst & l_cvtst ) == 0 ) error('NIANI'); end;
    if ~( sum( l_cvtst & l_cvtra ) == 0 ) error('NIANI'); end;
  end
elseif ~all(l_cv)
  [Z_cvtra,Z_cvtst] = get_Z_cv2( y_true, ncvs, true(1,npatts) ); 
else
  r_tra = find(l_tra); 
  for i1=1:2:length(r_tra)
    y_true(r_tra(i1)) = -y_true(r_tra(i1)); 
  end
  [Z_cvtra,Z_cvtst] = get_Z_cv2( y_true, ncvs, true(1,npatts) ); 
end
