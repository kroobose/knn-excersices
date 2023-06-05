%
%
%
function [ret,pt] = pl_is_crossing( X, Y )

if ~( size(X) == [2,2] ), error('NAININININI'); end;
if ~( size(Y) == [2,2] ), error('NAININININI'); end;

A = [ X(:,1)-X(:,2), Y(:,2)-Y(:,1) ];
b = [ X(:,1)-Y(:,1) ];

pt  = [0 0]';
if cond(A) > 1e+16, 
  ret = 0;
  return;
end

alph = A\b;
pt  = [0 0]';
pt  = pt + (1-alph(1))*X(:,1) + alph(1)*X(:,2);
pt  = pt + (1-alph(2))*Y(:,1) + alph(2)*Y(:,2);
pt  = pt * 0.5;
ret  = 0;
if ( alph >= 0 & alph <= 1 ),
  ret = 1;
end
