%
% neneimat = get_neneimat( dmat, nneneis )
%
function neneimat = get_neneimat( dmat, nneneis )

neneimat = zeros(size(dmat));
for j=1:size(dmat,1)
  [tmp,r_srt] = sort(dmat(j,:));
  neneimat(j,r_srt(2:(nneneis+1))) = 1;
end
neneimat = neneimat + neneimat' > 0;



