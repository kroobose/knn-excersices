function Z=rprod(X,Y)
% row product
% function Z=rprod(A,b)
% diag(b^T) * A = [ b_1 a_1; ..; b_N a_N ], 
% where A = [ a_1; ..; a_N ] : N x D
%       b = [ b_1; ..; b_N ] : N x 1

if(length(X(:,1)) ~= length(Y(:,1)) | length(Y(1,:)) ~=1)
  disp('Error in RPROD');
  return;
end

[N M]=size(X);
if issparse(X)
  Z = sparse(N,M);
else
  Z = zeros(N,M);
end

for i=1:length(X(1,:))
  Z(:,i)=X(:,i).*Y;
end
