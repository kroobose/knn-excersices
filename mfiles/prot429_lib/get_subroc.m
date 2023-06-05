function ret = get_subroc( ghat_tst, y_tst, ratio )
%
% ret = get_subroc( ghat_tst, y_tst, ratio )
%
% Return the area under ROC curve between FP ratios 
% of 0 to the specified ratio. 
%

ghat_tst = full(ghat_tst(:));
y_tst    = full(y_tst(:));
ntsts    = numel(y_tst); 
tsassert( isscalar(ratio) ); 
tsassert( ratio >= 0 ); 
tsassert( ratio <= 1 ); 
tsassert( numel(ghat_tst) == ntsts ); 


[fp,tp]=calcroc( ghat_tst, y_tst );
curve = [fp(:),tp(:)]; 
ret = get_subauc( curve, [0,ratio] ); 


