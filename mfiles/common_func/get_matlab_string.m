%
%
%
function ret = get_matlab_string(X)

nrows = size(X,1); 
ncols = size(X,2); 
ret = '['; 
for j=1:nrows
  for i=1:ncols
    ret = sprintf('%s %g',ret,X(j,i)); 
  end
  if j < nrows, 
    ret = sprintf('%s;',ret); 
  end
end
ret = sprintf('%s]',ret); 