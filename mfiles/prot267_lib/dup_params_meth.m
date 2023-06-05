%
% params_new = dup_params_meth( params_old, fld, values )
%
function params_new = dup_params_meth( params_old, fld, values )

nparams_old = length( params_old ); 
nvalues     = length( values ); 
params_new  = cell(0,0); 
if ~( isvarname( fld ) ) error('NAINII1'); end; 

if iscell( values )
elseif isnumeric( values )
elseif islogical( values )
elseif ischar( values )
  error('NAINII ischar');
elseif isempty( values )
  error('NAINII isempty');
elseif isstruct( values )
  error('NAINII isstruct');
else
  error('NANINI2'); 
end

if ~( prod(size( values )) == nvalues ) error('NAINII1'); end;

params_new = cell(0,0); 
for i1=1:nparams_old
  for i2=1:nvalues
    param_meth = params_old{i1}; 
    if iscell( values )
      param_meth = setfield( param_meth, fld, values{i2} ); 
    else
      param_meth = setfield( param_meth, fld, values(i2) ); 
    end
    params_new{end+1} = param_meth; 
  end
end






