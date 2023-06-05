function mahadmat = get_mahadist( X, Y, A ) 
%
%
%

nxs     = size(X,2); 
nys     = size(Y,2); 
ndims   = size(X,1); 
tsassert( size(X) == [ndims,nxs] ); 
tsassert( size(Y) == [ndims,nys] ); 

if iscell(A)

  tsassert( numel(A) == nys ); 
  mahadmat = zeros( nxs, nys ); 
  for i_y=1:nys
    mahadmat(:,i_y) = get_mahadist( X, Y(:,i_y), A{i_y} ); 
  end
  
else

  tsassert( size(A) == [ndims,ndims] ); 
  A        = 0.5*(A+A'); 
  K_xy     = X'*A*Y; 
  kself_x  = csum(X.*(A*X))'; 
  kself_y  = csum(Y.*(A*Y))'; 
  mahadmat = kself_x*ones(1,nys)+ones(nxs,1)*kself_y'-2*K_xy; 

end






