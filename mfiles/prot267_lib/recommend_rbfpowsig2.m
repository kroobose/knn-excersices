%
% powsig = recomment_rbfpowsig1( powdmat, nneneis )
%
function powsig = recommend_rbfpowsig2( powdmat, nneneis )

neneimat = logical(get_ranked_neneimat( powdmat, nneneis ) == nneneis );
powsig   = sum(powdmat(neneimat)) / nnz(neneimat);




