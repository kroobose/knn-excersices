%
% sum = matmul(As,x)
%
function sum = matmul(As,x)

if iscell(As)
  M     = size(As{1},1);
  N     = size(As{1},2);
  nmats = length(As);
  tsassert( numel(x) == nmats ); 

  if ( issparse(As{1}) ) 
    sum = sparse([],[],[],M,N,0); 
  else 
    sum = zeros(M,N);
  end

  for k=1:nmats
    sum = sum + As{k}*x(k);
  end

else

  sz = size(As); 
  tsassert( numel(sz) == 3 ); 
  M = sz(1); N = sz(2); nmats = sz(3); 
  tsassert( numel(x) == nmats ); 
  sum = reshape( As, [M*N,nmats] )*x; 
  sum = reshape( sum, [M,N] ); 
  
end


