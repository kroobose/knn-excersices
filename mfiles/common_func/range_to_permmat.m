%
%
%
function mat = range_to_permmat(r)

if size(r,2) == 1, r = r'; end;
n = length(r);
if sort(r) ~= 1:n, error('NANIININI'); end;
mat = sparse(1:n,r,ones(1,n),n,n);




