%
% pri_accmat_textable( format, accmat, stdmat, params )
% 
% Example:
%   
%   pri_accmat_textable( '%5.3f', accmat, stdmat, params )
%
function [lns_out,lmat_mx1,lmat_mx2] = pri_accmat_textable( format, accmat, stdmat, params )

nrows = size(accmat,1);
ncols = size(accmat,2);
tsassert( all(size(stdmat) == [nrows,ncols]) || numel(stdmat)==0 ); 

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
  if ~( numel(rownames) == nrows | numel(rownames) == 0 ) error('NIANII2'); end; 

  if ( isfield(params,'colnames') )
    colnames = params.colnames; 
  end
  if ~( iscellstr(colnames) ) error('NIANII3'); end; 
  if ~( numel(colnames) == ncols | numel(colnames) == 0 ) error('NIANII4'); end; 

end

is_tab = ones(1,ncols); 
if ( isfield(params,'is_tab') ) & numel(params.is_tab) > 0, 
  is_tab = params.is_tab; 
end
is_tab = is_tab(:)'; 
tsassert( numel(is_tab) == ncols ); 

%
% Compute lmat_mx1
%
hyplvl = 0.01; 
if ( isfield( params, 'hyplvl' ) )
  hyplvl = params.hyplvl; 
end
lmat_mx1   = false( nrows, ncols ); 
if ( isfield( params, 'ptabs' ) )
  if ~( numel(params.ptabs) == nrows ) error('NIANIN'); end; 
  lmat_tmp1 = accmat >= rmax(accmat)*ones(1,ncols); 
  for j=1:nrows
    ptab = params.ptabs{j}; 
    lmat_mx1(j,:) = csum(ptab(lmat_tmp1(j,:),:) > 0.01) >= 1; 
  end
end

%
% Compute lmat_mx2
%
accmat_round = accmat*0.0; 
for j=1:nrows
  for i=1:ncols
    accmat_round(j,i) = str2double( sprintf( format, accmat(j,i) ) ); 
  end
end
lmat_mx2 = accmat_round >= rmax(accmat_round)*ones(1,ncols); 

lns_out = cell(0,0); ln_out = ''; 
ntabs = max(is_tab); 
for i_tab=1:ntabs

  if i_tab > 1
    ln_out = sprintf('\\\\ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'); lns_out{end+1} = ln_out; ln_out = ''; 
  end
  
  l_col = is_tab == i_tab; 
  r_col = find(l_col); 
  ncols_tab = numel(r_col); 

  ln_out = sprintf('%s\\begin{tabular}{',ln_out); 
  if numel( rownames ) > 0,
    ln_out = sprintf('%s|c|',ln_out); 
  end
  for i=1:ncols_tab
    ln_out = sprintf('%sc',ln_out); 
  end
  ln_out = sprintf('%s|}',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 

  if numel( colnames ) > 0,
    if numel( rownames ) > 0,
      ln_out = sprintf('%s \\hline & ',ln_out); 
    end
    for i0=1:ncols_tab
      i = r_col(i0); 
      ln_out = sprintf('%s%s',ln_out,strrep(colnames{i},'_','\_'));
      if i0 < ncols_tab
	ln_out = sprintf('%s & ',ln_out);
      else
	ln_out = sprintf('%s\\\\ \\hline',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 
      end
    end
  end

  fmt_accstd   = sprintf('%s (%s)', format, format ); 
  fmt_accstdbf = sprintf('textbf{%s} (%s)', format, format ); 


  for j=1:nrows
    if numel( rownames ) > 0,
      ln_out = sprintf('%s%s & ', ln_out, strrep(rownames{j},'_','\_') );
    end
    for i0=1:ncols_tab
      i = r_col(i0); 
      str = sprintf( format, accmat(j,i) ); 
      if ( lmat_mx1(j,i) )
	str = sprintf( '\\underbar{%s}', str ); 
      end
      if ( lmat_mx2(j,i) )
	str = sprintf( '\\textbf{%s}', str ); 
      end
      ln_out = sprintf('%s%s ',ln_out, str); 
      if ( numel(stdmat) > 0 )
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
  ln_out = sprintf('%s\\hline \\end{tabular}',ln_out); lns_out{end+1} = ln_out; ln_out = ''; 

end
write_lns('stdout',lns_out); 



