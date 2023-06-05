% function Z=cmin(X)

function [Z,inds]=cmin(X)

if nargout == 1, 
  Z = min(X,[],1); 
else
  [Z,inds] = min(X,[],1); 
end

% [M N]=size(X);

% Z=zeros(N,1);

% if M==1,
%   Z = X;
%   r = ones(1,N);
% else
%   [Z,r] = min(X);
% end
