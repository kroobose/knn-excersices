% row max
% function [Z,I]=rmax(X)

function [Z,I]=rmax(X)

if nargout == 1, 
  Z = max(X,[],2); 
else
  [Z,I] = max(X,[],2); 
end

% [N M]=size(X);

% Z=zeros(N,1);

% if M==1,
%   Z = X;
%   I = ones(N,1);
% else
%   [Z,I]=max(X');
%   Z = Z'; I = I';
% end
