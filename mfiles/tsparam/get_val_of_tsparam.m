%
%
%
function val1 = get_val_of_tsparam( tsparam, key1 )

nvals = size( tsparam, 1 );
if ~( size(tsparam) == [nvals,2] ) error('NANININII1'); end; 

exists_key = 0;
for i_key=1:nvals
  if strcmp( key1, tsparam{i_key,1} ), 
    val1 = tsparam{i_key,2};
    exists_key = 1;
  end
end
if ~exists_key
  error('No keys');
end




