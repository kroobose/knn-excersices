%
% [ret,pt] = pl_is_crossing_with_infline( X, w, b )
% 
% $B@~J,(B X $B$HD>@~(B dot(w,x)+b = 0 $B$H$N8rE@$,$"$k$+$I$&$+JV$9!%(B
%
function [ret,pt] = pl_is_crossing_with_infline( X, w, b )

if ~( size(X) == [2,2] ), error('NAININININI'); end;
if ~( size(w) == [2,1] ), error('NAININININI'); end;
if ~( size(b) == [1,1] ), error('NAININININI'); end;

% $BJ?9T$J$i$P8rE@$J$7!%(B
deno = dot(w,X(:,2)-X(:,1));

pt = [0 0]';
if abs(deno) < 1e-6,
  ret = 0;
  return;
end

nume = -b-dot(w,X(:,1));
alph = nume / deno;
pt   = (1-alph)*X(:,1) + alph*X(:,2);
ret  = 0;
if ( alph >= 0 & alph <= 1 ),
  ret = 1;
end
