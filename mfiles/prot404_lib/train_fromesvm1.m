function [w_est,res] = train_fromesvm1( X, cs, w0, param )
%
%
%

w0 = w0(:); cs = cs(:); 
ndims = size( X, 1 ); 
ncons = size( X, 2 ); 
tsassert( size(X)  == [ndims,ncons] ); 
tsassert( size(cs) == [ncons,1] ); 
tsassert( size(w0) == [ndims,1] ); 

if nargin <= 3, 
  param.default = 1;
end

niters = 100; 
if isfield( param, 'niters' )
  niters = param.niters; 
end

thres_gap = 1e-3; 
if isfield( param, 'thres_gap' )
  thres_gap = param.thres_gap; 
end

mode_rec = 0; 
if isfield( param, 'mode_rec' )
  mode_rec = param.mode_rec; 
end

objs_primal = []; 
objs_dual   = []; 
alphs_rec   = cell(0,0); 
alph  = zeros( ncons, 1 ); 
w_new = zeros( ndims, 1 ); 
v_new = zeros( ndims, 1 ); 

dual_gap = 1e+100; 
for iter=1:niters
  for k=1:ncons
    w_old = w_new; v_old = v_new; 
    alph_old = alph(k); 
    xk       = X(:,k); 
    ck       = cs(k); 
    alph_new = alph_old - (dot(w_old,xk)-1)/dot(xk,xk); 
    alph_new = min( max( alph_new, 0 ), ck ); 
    alph(k)  = alph_new; 
    v_new    = v_old + (alph_new-alph_old)*xk; 
    w_new    = max( w0 + v_new, 0 ); 

    if mode_rec >= 2 || ( k==ncons && mode_rec >= 1 ) 
      [obj_primal,obj_dual,res_obj] = ...
          get_obj_fromesvm1( w_new, alph, X, cs, w0, param );
      objs_primal(end+1) = obj_primal; 
      objs_dual(end+1)   = obj_dual; 
      dual_gap = obj_primal - obj_dual; 
    end
  end
  if mode_rec >= 3, alphs_rec{iter} = alph; end
  if dual_gap < thres_gap, break; end; 
end

w_est = w_new; 
res.objs_primal = objs_primal; 
res.objs_dual   = objs_dual; 
res.alphs_rec   = alphs_rec; 
