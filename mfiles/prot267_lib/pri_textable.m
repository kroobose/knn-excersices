%
% pri_textable( format, A )
% 
% Example:
%   pri_textable( '%5.3f', A )
%
function pri_textable( format, A, params )

nrows = size(A,1);
ncols = size(A,2);

rownames = cell(0,0);
colnames = cell(0,0);
if ( nargin >= 3 )

  if ( isfield(params,'rownames') )
    rownames = params.rownames; 
  end
  if ~( iscellstr(rownames) ) error('NIANII1'); end; 
  if ~( length(rownames) == nrows | length(rownames) == 0 ) error('NIANII2'); end; 

  if ( isfield(params,'colnames') )
    colnames = params.colnames; 
  end
  if ~( iscellstr(colnames) ) error('NIANII3'); end; 
  if ~( length(colnames) == ncols | length(colnames) == 0 ) error('NIANII4'); end; 

end

if length( colnames ) > 0,
  if length( rownames ) > 0,
    fprintf(' & '); 
  end
  for i=1:ncols
    fprintf('%s',colnames{i});
    if i < ncols
      fprintf(' & ');
    else
      fprintf('\\\\ \n');
    end
  end
end

for j=1:nrows
  if length( rownames ) > 0,
    fprintf('%s & ', rownames{j} );
  end
  for i=1:ncols
    fprintf(format,A(j,i));
    if i < ncols
      fprintf(' & ');
    else
      fprintf('\\\\ \n');
    end
  end
end

