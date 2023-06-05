% row cumsum
% function Z=rcumsum(X)

function Z=rcumsum(X)

[N M]=size(X);

if M==1,
  Z=X;
else
  Z=cumsum(X')';
end
