% column mean
% function Z=cstd(X)

function Z=cstd(X,flag)

if nargin == 1,
  flag = 1;
end
Z = std(X,flag,1); 

% N=length(X(:,1));
% ncols = size(X,2); 
% if (N>1)
%   Z=std(X);
% elseif N==1;
%   disp('Warning in cstd' );
%   Z=zeros(size(X));
% elseif N==0,
%   Z=ones(1,ncols)*nan; 
% end;
