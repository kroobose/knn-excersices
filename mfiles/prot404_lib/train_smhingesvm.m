function [w_est,res] = train_smhingesvm( X_tra, lam, m, param )
%
% 
%
nfeas = size(X_tra,1); 
ncons = size(X_tra,2); 
tsassert( size(X_tra) == [nfeas,ncons] ); 
tsassert( size(lam)   == [1,1] ); 
tsassert( size(m)     == [1,1] ); 

% if nargin <= 5, 
%   param.default = 1;
% end

niters = 500; 
if isfield( param, 'niters' )
  niters = param.niters; 
end

thres_gap = 1e-3; 
if isfield( param, 'thres_gap' )
  thres_gap = param.thres_gap; 
end

mode_stochas = 1; 
if isfield( param, 'mode_stochas' )
  mode_stochas = param.mode_stochas; 
end

mode_rec = 0; 
if isfield( param, 'mode_rec' )
  mode_rec = param.mode_rec; 
end

verbose = 1; 
if isfield( param, 'verbose' )
  verbose = param.verbose; 
end

alph_init = zeros(ncons,1); 
if isfield( param, 'alph_init' )
  alph_init = param.alph_init; 
  tsassert( size(alph_init) == [ncons,1] ); 
end

ncons = size(X_tra,2); 
pownorms_xk = zeros(ncons,1); 
for i_con=1:ncons
  xk = X_tra(:,i_con); 
  pownorms_xk(i_con) = norm(xk).^2; 
end

lossfun     = @(z) smhingeloss(z,m); 
lossfun_ast = @(alph) smhingeloss_ast(alph,m); 

objs_primal = []; 
objs_dual   = []; 
alph  = alph_init; 
w_new = zeros(nfeas,1); 
if norm(alph) > 0,
  w_new = (X_tra*alph)/(lam*ncons); 
end

gmat = zeros(ncons,niters); 
fmat = zeros(ncons,niters); 

iter = 0; finished = 0; 
while ~finished, 
  iter = iter + 1; 

  if mode_stochas == 0,
    r_con = 1:ncons; 
  elseif mode_stochas == 1,
    r_con = randperm(ncons); 
  end
  
  for i_k=1:numel(r_con); 
    k = r_con(i_k); 

    if mode_rec > 0 || i_k == 1,

      w_recon = (X_tra*alph)/(lam*ncons); 
      zs    = X_tra'*w_recon; 
      term1_p = 0.5*lam*norm( w_recon ).^2; 
      term2_p = sum(lossfun(zs))/ncons; 
      obj_p = term1_p + term2_p; 

      term1_d = -0.5*lam*norm( w_recon ).^2; 
      term2_d = -sum(lossfun_ast(-alph))/ncons; 
      obj_d = term1_d + term2_d; 

      % [obj_p, obj_d] = ...
      %   get_obj_bijmet7m( alph, Beta, gam, As, lam, M, m, W0 );
      fmat( i_k, iter ) = obj_p; gmat( i_k, iter ) = obj_d; 
      if verbose > 0,
        fprintf('(%d,%d)a: f=%g, g=%g\n', iter, i_k, obj_p, obj_d ); 
      end
      if i_k >= 2, 
        tsassert( gmat(i_k,iter)-gmat(i_k-1,iter) >= -1e-6 ); 
      end
    else
      % fprintf('.'); 
    end

    w_old     = w_new; 
    xk        = X_tra(:,k); 
    alphk_old = alph(k); 
    yk        = w_old - xk*(alphk_old/(lam*ncons)); 
    term1_a   = 1 - tsdot(yk,xk); 
    term2_a   = pownorms_xk(k)/(lam*ncons) + m; 
    alphhat   = term1_a/term2_a; 

    alphk_new = min(max(alphhat,0),1); 
    alph(k)   = alphk_new; 
    w_new     = yk + xk*(alphk_new/(lam*ncons)); 
    
  end

  
  if iter >= 2 && abs(fmat(1,iter)- gmat(1,iter-1))<1e-5,
    finished = 1; 
  end
  if iter == niters,
    finished = 1; 
  end

end

if verbose > 0,fprintf('\n'); end
w_est    = w_new; 
res.fmat = fmat; 
res.gmat = gmat; 
res.alph = alph; 
res.iter = iter; 
res.dualgap = fmat(1,iter)- gmat(1,iter-1); 
