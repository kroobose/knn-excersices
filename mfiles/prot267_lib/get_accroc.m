%
% Must not include the scores of the training data 
% in ghat and y_orac. 
%  get_accroc( ghat_tst, y_tst, mode )
%
function ret = get_accroc( ghat_tst, y_tst, mode )

ghat_tst = full(ghat_tst(:));
y_tst = full(y_tst(:));

if ( strcmp( mode, 'acc' ) )

  ntsts = sum( y_tst ~= 0 ); 
  ret   = sum(ghat_tst.*y_tst > 0) / ntsts; 

elseif ( strcmp( mode, 'roc' ) )

  ret   = calcrocscore( ghat_tst, y_tst ); 

elseif ( strcmp( mode, 'roc10' ) )

  [fp,tp]=calcroc( ghat_tst, y_tst );
  curve = [fp(:),tp(:)]; 
  ret = get_subauc( curve, [0,0.1] ); 

elseif ( strcmp( mode, 'roc05' ) )

  [fp,tp]=calcroc( ghat_tst, y_tst );
  curve = [fp(:),tp(:)]; 
  ret = get_subauc( curve, [0,0.05] ); 

elseif ( strcmp( mode, 'aupr' ) )

  ret = get_fauc_precrecall( ghat_tst, y_tst );

elseif ( strcmp( mode, 'fmax-pr' ) )

  ret = get_fmax_precrecall( ghat_tst, y_tst );

else

  tsassert( 0 ); 

end
