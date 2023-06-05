function XT = weiran_simplexproj( YT )
%
% Projection onto the probability simplex
% https://ts3.pl.cs.gunma-u.ac.jp/tsattach1/kato/161117/Weiran-Wang-2013,-Projection-onto-the-probability-simplex.pdf
%
nfeas = size(YT,1); 
npts  = size(YT,2); 
if npts == 0,
  XT = YT;
  return; 
end

Y = YT'; 
[N,D] = size(Y);
X = sort(Y,2,'descend');
Xtmp = (cumsum(X,2)-1)*diag(sparse(1./(1:D)));
X = max(bsxfun(@minus,Y,Xtmp(sub2ind([N,D],(1:N)',...
                                     sum(X>Xtmp,2)))),0);
XT = X'; 

