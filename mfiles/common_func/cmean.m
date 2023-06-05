% column mean
% function Z=cmean(X)

function Z=cmean(X)

Z = mean(X,1); 
% N=length(X(:,1));
% ncols = size(X,2); 
% if (N>1)
%   Z=mean(X);
% elseif N==1,
%   Z=X;
% elseif N==0,
%   Z=ones(1,ncols)*nan; 
% end;
