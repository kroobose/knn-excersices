function [Z,inds]=csort(X)
% [Z,inds]=csort(X)
% column sort
% 
%

if nargout == 1, 
  Z = sort(X,1); 
else
  [Z,inds] = sort(X,1); 
end

% N=length(X(:,1));
% if (N>1)
%   [Z,inds]=sort(X);
% else
%   Z    = X;
%   inds = ones(1,length(Z));
% end;
