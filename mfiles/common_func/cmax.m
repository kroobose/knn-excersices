% column max
% function [Z,inds]=cmax(X)
%
function [Z,inds]=cmax(X)

if nargout == 1, 
  Z = max(X,[],1); 
else
  [Z,inds] = max(X,[],1); 
end

% N=length(X(:,1));
% if (N>1)
%   [Z,inds]=max(X);
% else
%   Z    = X;
%   inds = ones(1,length(Z));
% end;