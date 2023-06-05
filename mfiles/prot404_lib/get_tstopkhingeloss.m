function [loss,res] = get_tstopkhingeloss(scomat,y_tra,k_tk)
%
% topk hinge loss
%

ncts  = size(scomat,1); 
ntras = size(scomat,2); 
tsassert( size(y_tra) == [ntras,1] ); 
tsassert( k_tk < ncts ); 
Z_ct  = full(sparse(y_tra,1:ntras,ones(1,ntras),ncts,ntras)); 
sdfmat = rplus( scomat, -csum(scomat.*Z_ct) ); 
[sdfmat_srt,r_srt] = sort(sdfmat+1-Z_ct,'descend'); 
phid = cmean(sdfmat_srt(1:k_tk,:)); 
loss = max(0,phid); 
if nargout >= 2,
  fprintf('Do not USE 2nd argout of get_tstopkhingeloss.m\n'); 
  res.phid  = phid; 
  res.r_srt = r_srt; 
  if ntras == 1, 
    y_inp = y_tra; 
    grad = zeros(ncts,1); 
    if phid > 0,
      grad(r_srt(1:k_tk)) = 1./k_tk ; 
      grad = grad - unitvec(y_inp,ncts); 
    end
    res.grad = grad; 
  end
end
