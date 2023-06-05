%
% neneimat = get_ranked_neneimat( dmat, nneneis )
%
function neneimat = get_ranked_neneimat( dmat, nneneis )

neneimat = ones(size(dmat))*(nneneis+1);
for j=1:size(dmat,1)
  [tmp,r_srt] = sort(dmat(j,:));
  tmp1 = neneimat(j,r_srt(2:(nneneis+1)));
  tmp2 = min( tmp1, 1:nneneis );
  neneimat(j,r_srt(2:(nneneis+1))) = tmp2;
  neneimat(r_srt(2:(nneneis+1)),j) = tmp2';
end
neneimat(find(neneimat==(nneneis+1))) = 0;




