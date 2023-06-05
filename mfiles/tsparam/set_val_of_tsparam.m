%
%
%
function tsparam = set_val_of_tsparam( tsparam, key1, val1 )

nvals = size( tsparam, 1 );
exists_key = 0;
for i_key=1:nvals
  if strcmp( key1, tsparam{i_key,1} ), 
    tsparam{i_key,2} = val1;
    exists_key = 1;
  end
end
if ~exists_key
  tsparam{end+1,1} = key1;
  tsparam{end,2} = val1;
end





