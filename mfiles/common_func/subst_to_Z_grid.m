function Z_grid = subst_to_Z_grid( lls_grid, len_x2s, len_x1s )
%
%
%
tsassert( numel(lls_grid) == len_x2s*len_x1s ); 
Z_grid = zeros( len_x2s, len_x1s ); 
k = 0; 
for i1=1:len_x1s 
  for i2=1:len_x2s 
    k = k + 1; 
    Z_grid(i2,i1) = lls_grid(k); 
  end
end


