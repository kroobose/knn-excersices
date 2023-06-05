function [ret,res] = get_accroc2( ghat_tst, y_tst, mode )
%
% [ret,res] = get_accroc( ghat_tst, y_tst, mode )
%
% Version 2.00:
%   Some bugs found and fixed on Sept 28, 2013.  
%   Different values are computed from the previous version 
%   when using 'aupr' and 'fmax-pr'. 
%   'roc01', 'sens10', 'sens05', 'sens01', and 'prbep' are added newly. 
%   roc01 is the area under ROC curve in [0,0.01], 
%   sens10 is the sensitivity at specificity of 0.90. 
%   sens05 is the sensitivity at specificity of 0.95. 
%   sens01 is the sensitivity at specificity of 0.99. 
%   prbep is the precision/recall breakeven point. 
%
%
% Must not include the scores of the training data 
% in ghat and y_orac. 
%  get_accroc( ghat_tst, y_tst, mode )
%
%

ghat_tst = full(ghat_tst(:));
y_tst = full(y_tst(:));
res   = []; 

if ( strcmp( mode, 'acc' ) )

  ntsts = sum( y_tst ~= 0 ); 
  ret   = sum(ghat_tst.*y_tst > 0) / ntsts; 
  
elseif ( strcmp( mode, 'roc' ) )

  ret = get_subroc( ghat_tst, y_tst, 1.0 );

elseif ( strcmp( mode, 'roc10' ) )

  ret = get_subroc( ghat_tst, y_tst, 0.1 );

elseif ( strcmp( mode, 'roc05' ) )

  ret = get_subroc( ghat_tst, y_tst, 0.05 );

elseif ( strcmp( mode, 'roc01' ) )

  ret = get_subroc( ghat_tst, y_tst, 0.01 );

elseif ( strcmp( mode, 'sens10' ) )

  [fp,tp]=calcroc( ghat_tst, y_tst ); curve_roc = [fp(:),tp(:)]; 
  ret   = get_y_on_auccurve( 0.10, curve_roc ); 

elseif ( strcmp( mode, 'sens05' ) )

  [fp,tp]=calcroc( ghat_tst, y_tst ); curve_roc = [fp(:),tp(:)]; 
  ret   = get_y_on_auccurve( 0.05, curve_roc ); 

elseif ( strcmp( mode, 'sens01' ) )

  [fp,tp]=calcroc( ghat_tst, y_tst ); curve_roc = [fp(:),tp(:)]; 
  ret   = get_y_on_auccurve( 0.01, curve_roc ); 

elseif ( strcmp( mode, 'aupr' ) )

  curve_pr = get_precrecall_curve2( ghat_tst, y_tst ); 
  x1s = curve_pr(1,1:end-1); 
  x2s = curve_pr(2,1:end-1); 
  nps = (numel(x1s)-1); 
  tsassert( norm(x1s-(0:nps)/nps) < 1e-8 ); 
  tsassert( curve_pr(:,1)   == [0;1] ); 
  tsassert( curve_pr(:,end) == [1;0] ); 
  ret = (2*sum(x2s(2:end-1))+x2s(1)+x2s(end))/(2*nps); 

elseif ( strcmp( mode, 'fmax-pr' ) )

  curve_pr = get_precrecall_curve2( ghat_tst, y_tst ); 
  tsassert( curve_pr(:,1)   == [0;1] ); 
  tsassert( curve_pr(:,end) == [1;0] ); 
  recalls = curve_pr(1,2:end-1); 
  precs   = curve_pr(2,2:end-1); 
  fmax_pr = 2*precs.*recalls./(precs+recalls); 
  [fmax_pr,i_tmp1] = max(fmax_pr); 
  ret     = fmax_pr; 
  res.recall = curve_pr(1,i_tmp1); 
  res.prec   = curve_pr(2,i_tmp1); 
  
elseif ( strcmp( mode, 'prbep' ) )  

  curve_pr = get_precrecall_curve2( ghat_tst, y_tst ); 
  x1s = curve_pr(1,:); x2s = curve_pr(2,:); 
  l_u  = x2s >= x1s;
  l_be = l_u(1:end-1) & ~(l_u(2:end)); 
  i_be = find(l_be); 
  tsassert( numel(i_be) == 1 ); 
  r1 = curve_pr(1,i_be);  r2 = curve_pr(1,i_be+1); 
  p1 = curve_pr(2,i_be);  p2 = curve_pr(2,i_be+1); 
  grad  = (p2-p1)/(r2-r1); 
  prbep = (grad*r1-p1)/(grad-1); 
  ret   = prbep;
  
else

  tsassert( 0 ); 

end
