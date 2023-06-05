%
%
%
function pri_lmat( lmat )

nrows = size(lmat,1);
ncols = size(lmat,2);
for j=1:nrows
  for i=1:ncols
    fprintf('%g',lmat(j,i));
  end
  fprintf('\n');
end


