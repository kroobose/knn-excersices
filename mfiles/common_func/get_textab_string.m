%
%
%
function ret = get_textab_string(X,mode)

if nargin == 1,
  mode = 'bmatrix'; 
end

nrows = size(X,1); 
ncols = size(X,2); 
ret = sprintf('\\begin{bmatrix}'); 
for j=1:nrows
  for i=1:ncols
    if X(j,i) == 0,
      ret = sprintf('%s 0',ret); 
    else
      if strcmp( mode, 'bmatrix' )
        ret = sprintf('%s %+g',ret,round(X(j,i)*10000)/10000); 
      elseif strcmp( mode, 'tabular' )
        ret = sprintf('%s $%+g$',ret,round(X(j,i)*10000)/10000); 
      end
    end
    if i < ncols,
      ret = sprintf('%s &',ret); 
    end
  end
  if j < nrows, 
    ret = sprintf('%s \\\\',ret); 
  end
end
ret = sprintf('%s\\end{bmatrix}',ret); 