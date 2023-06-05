%
%
%
function ret = pl_del_redundant_vertices(X)

ndims  = size(X,1);
npatts = size(X,2);
if ~(ndims == 2), error('NANIINII1'); end;
if ~(npatts >= 3), keyboard; error('NANIINII2'); end;

l_tmp = true(1,npatts);
for i0=1:npatts
  i1 = mod(i0+1-1,npatts)+1;
  y1 = X(:,i1)-X(:,i0);
  if norm(y1) < 1e-6,
    l_tmp(i0) = 0;
  end
end

X = X(:,l_tmp);
ret = X;
npatts = size(X,2);
if ~(npatts >= 3), error('NANIINII3'); end;
l_tmp = true(1,npatts);
i0    = 1;
i1    = 2;
k     = 0;
while ( k <= npatts && sum(l_tmp) >= 3 )
  k = k + 1;

  i2 = mod(i1+1-1,npatts)+1;    
  while ( ~l_tmp(i2) ) 
    i2 = mod(i2+1-1,npatts)+1; 
  end
  % disp([i0,i1,i2, l_tmp]);
  if ~all(l_tmp([i0,i1,i2])), 
    keyboard; error('NAINIINI'); 
  end;

  y1 = X(:,i1)-X(:,i0);
  y2 = X(:,i2)-X(:,i1);
  if ~(norm(y1)>1e-6), keyboard; error('NAINI'); end;
  if ~(norm(y2)>1e-6), keyboard; error('NAINI'); end;
  y1 = y1 / norm(y1);
  y2 = y2 / norm(y2);
  if max(abs(y2-y1)) > 1e-6,
    i0 = i1;
  else
    l_tmp(i1) = 0;
  end
  i1 = mod(i1+1-1,npatts)+1;    
  while ( ~l_tmp(i1) ) i1 = mod(i1+1-1,npatts)+1; end
end

X = X(:,l_tmp);
ret = X;
