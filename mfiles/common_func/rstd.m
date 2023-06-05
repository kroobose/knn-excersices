% row std
% function Z=rstd(X)

function Z=rstd(X,flag)

if nargin == 1,
  flag = 1;
end
Z = std(X,flag,2); 

% M     = rmean(X);
% ncols = size(X,2);
% if ( nargin == 1 )
%   flag = 0;
% end
% N = ncols-1;
% if ( flag )
%   N = ncols;
% end

% if ncols <= 1
%   disp('Warning in rstd' );
% end
% X     = X - M*ones(1,ncols);
% Z     = sqrt(rsum(X .* X) / N);