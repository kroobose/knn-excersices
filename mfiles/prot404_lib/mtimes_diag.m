function Z=mtimes_diag(A,b)
%
% A*diag(b)
%

[nrows ncols]=size(A);
b = b(:); 
tsassert( numel(b) == ncols ); 

if issparse(A)
  Z = sparse(nrows,ncols);
else
  Z = zeros(nrows,ncols);
end

if nrows<ncols,
  for n=1:nrows
    Z(n,:)=A(n,:).*b';
  end
else
  for m=1:ncols
    Z(:,m)=A(:,m)*b(m);
  end;
end;
