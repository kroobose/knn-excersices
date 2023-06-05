% STRPAD  ( MatLinks) Pad a string with the specified character.
%
%    STRPAD(S,N,C) pads the character string S with character C so
%    that
%    length(S)=N.  If length(S)>N then S is truncated to length N.
%    The default value for C=' ' (the space character).
%
%    See also DEBLANK.
%
%    Type HELP MATLINKS for a full listing of all MatLinks
%    ToolChest functions.
%
function s = strpad(s,n,c)

%--------------
% parse inputs
%--------------

error(nargchk(2,3,nargin));
if nargin == 2,
  c = ' ';
end;


%----------------------------
% pad or truncate the string
%----------------------------

if length(s)>=n,
  s = s(1:n);
else
  for i=length(s)+1:n,
    s = [s c];
  end;
end;


%===============================================================================
% End-Of-File
%===============================================================================
