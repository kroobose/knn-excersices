% column sum
% function Z=ccumsum(X)

function Z=ccumsum(X)

M=size(X,1);
if (M>1)
  Z=cumsum(X);
else
  Z=X;
end;