% row min
% function Z=rmin(X)

function [Z,I]=rmin(X)

if nargout == 1, 
  Z = min(X,[],2); 
else
  [Z,inds] = min(X,[],2); 
end

% [N M]=size(X);

% Z=zeros(N,1);

% if M==1,
%   Z=X; I = ones(N,1); 
% else
%   [Z,I]=min(X');
%   Z = Z'; I = I'; 
% end
