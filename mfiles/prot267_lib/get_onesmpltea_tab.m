%
% scoremat( i_meth, cv )  : nmeths x ncvs matrix. 
%
function ptab = get_onesmpltea_tab( scoremat )

nmeths = size(scoremat,1); 
ncvs   = size(scoremat,2); 

thres_zero = mean(vec(scoremat))*1e-4; 

ptab = eye(nmeths); 
for i1=1:nmeths
  for i2=1:nmeths
    if ( norm( scoremat(i1,:)-scoremat(i2,:) ) > 0 )
      ds   = scoremat(i1,:) - scoremat(i2,:); 
      dbar = mean(ds); sd = std(ds); 
      if ( sd > thres_zero )
	tval = dbar/(sd/sqrt(ncvs)); 
	ptab(i1,i2) = tcdf(-abs(tval),ncvs); 
      else
	ptab(i1,i2) = 1; 
      end
    else
      ptab(i1,i2) = 1;
    end
  end
end


