%
%
%
function ret = subsnmatref( nmat, rows, cols )

if ~isfield( nmat, 'A' ) error('NANINI1'); end;
if ~isfield( nmat, 'rows' ) error('NANINI2'); end;
if ~isfield( nmat, 'cols' ) error('NANINI3'); end;
if ~iscellstr( nmat.rows ) error('NANINI4'); end;
if ~iscellstr( nmat.cols ) error('NANINI5'); end;
nrows_old = length(nmat.rows);
ncols_old = length(nmat.cols);
if size(nmat.A) ~= [nrows_old,ncols_old], error('NANINI6'); end;

if iscellstr(rows)
  [r_a,r_b] = tsnamematch(nmat.rows,rows);
  [tmp,r_tmp] = sort(r_b);
  r_a = r_a(r_tmp);
  r_b = r_b(r_tmp);
  r_rows = r_a;
  if r_b ~= 1:length(rows), error('NANINININI'); end;
elseif ischar(rows) & strcmp( rows,':' )
  r_rows = 1:length(nmat.rows);
  rows   = nmat.rows;
elseif isnumeric(rows)
  r_rows = rows;
  rows   = subscellref( nmat.rows, r_rows );
elseif islogical(rows)
  r_rows = find(rows);
  rows   = subscellref( nmat.rows, r_rows );
else
  error('NAINININII');
end

if iscellstr(cols)
  [r_a,r_b]   = tsnamematch(nmat.cols,cols);
  [tmp,r_tmp] = sort(r_b);
  r_a         = r_a(r_tmp);
  r_b         = r_b(r_tmp);
  r_cols      = r_a;
  if r_b ~= 1:length(cols), error('NANINININI'); end;
elseif ischar(cols) & strcmp( cols,':' )
  r_cols = 1:length(nmat.cols);
  cols   = nmat.cols;
elseif isnumeric(cols)
  r_cols = cols;
  cols   = subscellref( nmat.cols, r_cols );
elseif islogical(cols)
  r_cols = find(cols);
  cols   = subscellref( nmat.cols, r_cols );
else
  error('NANININII');
end

ret.A    = nmat.A(r_rows, r_cols);
ret.rows = rows;
ret.cols = cols;
if isfield( nmat, 'lmat_v' )
  if size( nmat.lmat_v ) ~= [nrows_old, ncols_old], error('NANININIII'); end;
  ret.lmat_v = nmat.lmat_v(r_rows, r_cols);
end

