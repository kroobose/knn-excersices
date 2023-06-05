function [cts_pred,scoremat] = get_knnc( X_tst, X_tra, cts_tra, nneneis )
%
%
%

ndims_fea = size(X_tst,1); 
ntsts     = size(X_tst,2); 
ntras     = size(X_tra,2); 
cts_tra = cts_tra(:); 
tsassert( size(X_tra) == [ndims_fea,ntras] ); 
tsassert( size(X_tst) == [ndims_fea,ntsts] ); 
tsassert( size(cts_tra) == [ntras,1] ); 
tsassert( nneneis == floor(nneneis) & nneneis > 0 ); 
ncts = max(cts_tra); 

tmp1 = get_powdist(X_tra,X_tra);
beta = 1./median(tmp1(:)); 

dmat = get_powdist( X_tst, X_tra ); 
neneimat = zeros(size(dmat));
for j=1:size(dmat,1)
  [tmp,r_srt] = sort(dmat(j,:));
  neneimat(j,r_srt) = 1:ntras;
end
neneimat = neneimat <= nneneis; 

weimat   = exp(-0.5*beta*dmat); 
A        = neneimat.*(ones(ntsts,1)*cts_tra'); 
scoremat = zeros(ntsts,ncts); 
for ct_targ=1:ncts
  score = rsum((A == ct_targ).*weimat); 
  scoremat(:,ct_targ) = score; 
end

[tmp1,cts_pred] = rmax(scoremat); 
scoremat = scoremat'; 

