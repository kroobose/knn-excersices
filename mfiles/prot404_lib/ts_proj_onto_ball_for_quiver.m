function [umat_ret,vmat_ret] ...
    = ts_proj_onto_ball_for_quiver( umat, vmat, radi )
%
%
%

[nys,nxs] = size(umat); 
tsassert( size(umat) == [nys,nxs] ); 
tsassert( size(vmat) == [nys,nxs] ); 

nrmmat   = sqrt(umat.^2+vmat.^2); 
if nargin == 2,
  radi = median( nrmmat(:) ); 
end
scalemat = min(radi./nrmmat,1); 
umat_ret = umat.*scalemat; 
vmat_ret = vmat.*scalemat; 


