%
%
%
function ret = get_keys_of_tsparam( tsparam );

nvals = size( tsparam, 1 );
if ~( size(tsparam) == [nvals,2] ) error('NANININII1'); end; 

ret   = cell(1,nvals);
for i_key=1:nvals
  ret{i_key} = tsparam{i_key,1};
end





