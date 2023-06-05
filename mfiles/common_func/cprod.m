% function Z=cprod(A,b)
%
% column production: Z = A * b column-wise
% Y must have one row
% A * diag(b) = [ a_1*b_1 , .., a_N*b_N ], 
% where A = [ a_1, .., a_N ] : D x N
%       b = [ b_1, .., b_N ] : 1 x N

function Z=cprod(A,b)

[N M]=size(A);
[K L]=size(b);
if(M ~= L | K ~=1)
  error('Error in cprod');
end

if issparse(A)
  Z = sparse(N,M);
else
  Z = zeros(N,M);
end

if N<M,
  for n=1:N
    Z(n,:)=A(n,:).*b;
  end
else
  for m=1:M
    Z(:,m)=A(:,m)*b(m);
  end;
end;
