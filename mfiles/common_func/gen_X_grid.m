function X_grid = gen_X_grid( x1s, x2s )
%
%
%

X_grid = zeros(2,numel(x1s)*numel(x2s)); k = 0; 
for i1=1:numel(x1s)
  for i2=1:numel(x2s)
    x_tmp1 = [x1s(i1),x2s(i2)]'; 
    k = k + 1; 
    X_grid(:,k) = x_tmp1; 
  end
end
