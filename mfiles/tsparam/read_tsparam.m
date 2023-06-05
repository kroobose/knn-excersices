%
%
%
function tsparam = read_tsparam( file_in, file_typ )

lns_param = read_lns( file_in );
lns_typ   = read_lns( file_typ );

i_ln    = 1;
while ~strcmp( lns_param{i_ln}, 'EOF' )
  i_ln = i_ln + 1;
end
nvals = i_ln-1;

i_ln    = 1;
while ~strcmp( lns_typ{i_ln}, 'EOF' )
  i_ln = i_ln + 1;
end
nkeys = i_ln-1;

tsparam = cell( nvals, 2 );
for i_ln=1:nvals
  [key,valstr] = strtok( lns_param{i_ln} );
  tsparam{i_ln,1} = strtrim(key);
  tsparam{i_ln,2} = strtrim(valstr);
end

typs = cell( nkeys, 2 );
for i_ln=1:nkeys
  [key,typstr] = strtok( lns_typ{i_ln} );
  typs{i_ln,1} = strtrim(key);
  typs{i_ln,2} = strtrim(typstr);
end

for i_val=1:nvals
  key1    = tsparam{i_val,1};
  valstr1 = tsparam{i_val,2};
  typ   =  '';
  for i_key=1:nkeys
    if strcmp( key1, typs{i_key,1} ), 
      typ = typs{i_key,2};
    end
  end
  if strcmp( typ, 'b' )
    tsparam{i_val,2} = logical(str2num(valstr1));
  elseif strcmp( typ, 'i' )
    tsparam{i_val,2} = floor(str2num(valstr1));
  elseif strcmp( typ, 'd' )
    tsparam{i_val,2} = str2num(valstr1);
  elseif strcmp( typ, 's' )
    tsparam{i_val,2} = valstr1;
  elseif strcmp( typ, 'bv' )
    tsparam{i_val,2} = logical(str2num(valstr1));
  elseif strcmp( typ, 'iv' )
    tsparam{i_val,2} = floor(str2num(valstr1));
  elseif strcmp( typ, 'dv' )
    tsparam{i_val,2} = str2num(valstr1);
  elseif strcmp( typ, 'sv' )
    rem1 = valstr1; tmp1 = cell(1,0);
    while length(rem1) > 0,
      [tok1,rem1] = strtok( rem1 );
      tmp1{1,end+1} = tok1;
      rem1 = strtrim( rem1 );
    end
    tsparam{i_val,2} = tmp1;
  else
    error('NANINIII2');
  end
end











