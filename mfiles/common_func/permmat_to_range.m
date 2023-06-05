%
%
%
function r = permmat_to_range(mat)

n = size(mat,2);
if rsum(mat) ~= ones(n,1), error('NANININII1'); end;
if csum(mat) ~= ones(1,n), error('NANININII2'); end;
if max(mat)  ~= 1, error('NANININII3'); end;
if min(mat)  ~= 0, error('NANININII4'); end;

[r,j] = find(mat');
r     = r';




