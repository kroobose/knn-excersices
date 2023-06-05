% column lsume
% function Z=clsume(X)

function Z=clsume(X)

[nrows ncols]=size(X);

if (nrows>1)
  mx   = cmax(X);
  Z = log(csum(exp(X - ones(nrows,1)*mx)))+mx;
else
  Z=X;
end



