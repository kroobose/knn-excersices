%
%
%
function write_tsparam( file_out, tsparam )

nvals = size(tsparam,1);
if ~( size(tsparam) == [nvals,2] ) error('NANININII1'); end; 
keylens  = zeros(nvals,1);
for i_val=1:nvals
  keylens(i_val) = length( tsparam{i_val,1} );
end
maxlen = max(keylens);

lns_out = cell(nvals+1,1);
for i_val=1:nvals
  keystr = strpad(tsparam{i_val,1},maxlen+1);
  ncols  = length(vec(tsparam{i_val,2}));
  v      = vec(tsparam{i_val,2});
  if iscellstr(v)
    valstr = v{1};
    for i_col=2:ncols
      valstr = sprintf('%s %s',valstr,v{i_col});
    end
  elseif isa(v,'char')
    valstr = v';
  elseif ( isnumeric(v) & isreal(v) ) | islogical(v)
    v = full(v);
    valstr = num2str(v(1));
    for i_col=2:ncols
      valstr = sprintf('%s %s',valstr,num2str(v(i_col)));
    end
  else
    keyboard;     error('NAININIII1');
  end
  lns_out{i_val} = [keystr,valstr];
end
lns_out{nvals+1} = 'EOF';

write_lns( file_out, lns_out );







