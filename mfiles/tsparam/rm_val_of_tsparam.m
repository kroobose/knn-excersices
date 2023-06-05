%
%
%
function ret = rm_val_of_tsparam( tsparam, key1 )

nvals = size( tsparam, 1 );
i1_key = 0;
for i_key=1:nvals
  if strcmp( key1, tsparam{i_key,1} ), 
    i1_key = i_key;
  end
end
if i1_key == 0, error('ANIINII not found key'); end;

ret = cell(nvals-1,1);
for i_key=1:(i1_key-1)
  ret{i_key,1} = tsparam{i_key,1}; 
  ret{i_key,2} = tsparam{i_key,2}; 
end
for i_key=i1_key:(nvals-1)
  ret{i_key,1} = tsparam{i_key+1,1}; 
  ret{i_key,2} = tsparam{i_key+1,2}; 
end






