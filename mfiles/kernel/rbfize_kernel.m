%
% ret = rbfize_kernel(kernmat,sig)
% 
function ret = rbfize_kernel(kernmat,sig)

N       = size(kernmat,1);
if ( size(kernmat,2) ~= N ), err(1:3)=1:2; end;
xnorm   = diag(kernmat);
tmp     = ones(N,1)*xnorm';
powdmat = tmp+tmp'-2.0*kernmat;
ret     = exp( -0.5*powdmat/(sig*sig) );
