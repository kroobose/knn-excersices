%
% pri_accmat_textable( format, accmat, stdmat, params )
% 
% Example:
%   
%   pri_accmat_textable( '%5.3f', accmat, stdmat, params )
%
function lns_out = pri_errmat_textable( format, errmat, stdmat, params )

nrows = size(errmat,1);
ncols = size(errmat,2);
tsassert( all(size(stdmat) == [nrows,ncols]) || length(stdmat)==0 ); 

coloring = 0; 
if isfield( params, 'coloring' )
  coloring = params.coloring; 
end

%
% Check input data
%
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

is_tab = ones(1,ncols); 
if ( isfield(params,'is_tab') ) & length(params.is_tab) > 0, 
  is_tab = params.is_tab; 
end
is_tab = is_tab(:)'; 
tsassert( length(is_tab) == ncols ); 

%
% Compute lmat_mx1
%
hyplvl = 0.01; 
if ( isfield( params, 'hyplvl' ) )
  hyplvl = params.hyplvl; 
end
lmat_mx1   = false( nrows, ncols ); 
if ( isfield( params, 'ptabs' ) )
  if ~( length(params.ptabs) == nrows ) error('NIANIN'); end; 
  lmat_tmp1 = errmat <= rmin(errmat)*ones(1,ncols); 
  for j=1:nrows
    ptab = params.ptabs{j}; 
    lmat_mx1(j,:) = csum(ptab(lmat_tmp1(j,:),:) > 0.01) >= 1; 
  end
end

%
% Compute lmat_mx2
%
errmat_round = errmat*0.0; 
for j=1:nrows
  for i=1:ncols
    errmat_round(j,i) = str2double( sprintf( format, errmat(j,i) ) ); 
  end
end
lmat_mx2 = errmat_round <= rmin(errmat_round)*ones(1,ncols); 

lns_out = cell(0,0); ln_out = ''; 
ntabs = max(is_tab); 
for i_tab=1:ntabs

  if i_tab > 1
    ln_out = sprintf('\\\\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'); lns_out{end+1} = ln_out; ln_out = ''; 
  end
  
  l_col = is_tab == i_tab; 
  r_col = find(l_col); 
  ncols_tab = length(r_col); 

  ln_out = sprintf('%s\\begin{tabular}{',ln_out); 
  if length( rownames ) > 0,
    ln_out = sprintf('%sc',ln_out); 
  end
  for i=1:ncols_tab
    ln_out = sprintf('%sc',ln_out); 
  end
  ln_out = sprintf('%s}',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 

  if length( colnames ) > 0,
    if length( rownames ) > 0,
      ln_out = sprintf('%s & ',ln_out); 
    end
    for i0=1:ncols_tab
      i = r_col(i0); 
      ln_out = sprintf('%s%s',ln_out,strrep(colnames{i},'_','\_'));
      if i0 < ncols_tab
	ln_out = sprintf('%s & ',ln_out);
      else
	ln_out = sprintf('%s\\\\',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 
      end
    end
  end

  fmt_accstd   = sprintf('%s (%s)', format, format ); 
  fmt_accstdbf = sprintf('textbf{%s} (%s)', format, format ); 


  for j=1:nrows
    if length( rownames ) > 0,
      ln_out = sprintf('%s%s & ', ln_out, strrep(rownames{j},'_','\_') );
    end
    for i0=1:ncols_tab
      i = r_col(i0); 
      str = sprintf( format, errmat(j,i) ); 
      if ( lmat_mx1(j,i) )
	str = sprintf( '\\underbar{%s}', str ); 
      end
      if ( lmat_mx2(j,i) )
	str = sprintf( '\\textbf{%s}', str ); 
      end
      if ( errmat(j,i) > 0 )
	str = sprintf( '\\textcolor{red}{%s}', str ); 
      elseif ( errmat(j,i) < 0 )
	str = sprintf( '\\textcolor{blue}{%s}', str ); 
      end
      % str = sprintf('$%s$',str); 
      ln_out = sprintf('%s%s ',ln_out, str); 
      if ( length(stdmat) > 0 )
	str = sprintf(format,stdmat(j,i)); 
	ln_out = sprintf('%s(%s) ',ln_out,str); 
      end
      if i0 < ncols_tab
	ln_out = sprintf('%s & ',ln_out);
      else
	ln_out = sprintf('%s\\\\',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 
      end
    end
  end
  ln_out = sprintf('%s\\end{tabular}',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 
end
write_lns('stdout',lns_out); 

lmat_mx1


