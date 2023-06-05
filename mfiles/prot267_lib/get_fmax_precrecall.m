%
%
%
function fmx = get_fmax_precrecall( ghat, y_orac )

l_tst  = abs(y_orac) > 0;
ghat   = ghat(l_tst); 
y_orac = y_orac(l_tst); 

[prec,recall] = get_precrecall_curve( ghat, y_orac );
nume = 2 * prec .* recall; 
deno = prec + recall; 
fvals = nume ./ deno; 
fmx   = max( fvals ); 



