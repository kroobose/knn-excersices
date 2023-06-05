%
% scoremat( i_meth, cv )  : nmeths x ncvs matrix. 
%
function ptab = get_wilcoxon_sgnrank_tab( scoremat )

nmeths = size(scoremat,1); 
ncvs   = size(scoremat,2); 

ptab = eye(nmeths); 
for i1=1:nmeths
  for i2=1:nmeths
    if ( norm( scoremat(i1,:)-scoremat(i2,:) ) > 0 )
      ds = scoremat(i1,:) - scoremat(i2,:); 
      ptab(i1,i2) = do_wilcoxon_sgnrank( ds ); 
    else
      ptab(i1,i2) = 1;
    end
  end
end


