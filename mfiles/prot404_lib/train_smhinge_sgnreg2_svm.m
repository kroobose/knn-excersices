function [w_est,res] ...
    = train_smhinge_sgnreg2_svm( X_tra, lam, m, param )
% 
% 
% 
nfeas = size(X_tra,1); 
ntras = size(X_tra,2); 
tsassert( size(X_tra) == [nfeas,ntras] ); 
tsassert( isscalar(lam) ); 

if nargin <= 2, 
  param.default = 1;
end

niters = 1000; 
if isfield( param, 'niters' )
  niters = param.niters; 
end

thres_gap = 1e-5; 
if isfield( param, 'thres_gap' )
  thres_gap = param.thres_gap; 
end

mode_stochas = 0; 
if isfield( param, 'mode_stochas' )
  mode_stochas = param.mode_stochas; 
end

mode_rec = 0; 
if isfield( param, 'mode_rec' )
  mode_rec = param.mode_rec; 
end

ncons = size(X_tra,2); 
pownorms_xk = zeros(ncons,1); 
for i_con=1:ncons
  xk = X_tra(:,i_con); 
  pownorms_xk(i_con) = norm(xk).^2; 
end

l_sgn = true(nfeas,1); 
if isfield( param, 'l_sgn' ),
  l_sgn = param.l_sgn;
end
tsassert( numel(l_sgn) == nfeas ); 

alph_init = zeros(ncons,1); 
if isfield( param, 'alph_init' ),
  alph_init = param.alph_init; 
end
tsassert( size(alph_init) == [ncons,1] ); 

verbose = 1; 
if isfield( param, 'verbose' )
  verbose = param.verbose; 
end

lossfun     = @(z) smhingeloss(z,m); 
lossfun_ast = @(alph) smhingeloss_ast(alph,m); 
regfun_p = @(W)get_signreg2_p(W,l_sgn);
regfun_d = @(V)get_signreg2_d(V,l_sgn);
if norm(alph_init) > 0,
  alph  = alph_init; 
  v_new = (X_tra*alph)/(lam*ncons); 
else
  alph  = zeros(ncons,1); 
  v_new = zeros(nfeas,1); 
end
[tmp1,w_new] = get_signreg2_d(v_new,l_sgn);
objs_primal = []; 
objs_dual   = []; 
lamn  = lam*ntras; 
ilamn = 1./lamn; 

if mode_rec > 0,
  ncons_recfg = ncons; 
else
  ncons_recfg = ceil(ncons/100);   
end
gmat = zeros(ncons_recfg,niters); 
fmat = zeros(ncons_recfg,niters); 
V_rec = zeros( nfeas, ncons, 0 ); 
W_rec = zeros( nfeas, ncons, 0 ); 
A_rec = zeros( ncons, ncons, 0 ); 

iter = 0; finished = 0; 
while ~finished, 
  iter = iter + 1; 

  tsassert( ~any(isnan(w_new)) ); 
  
  if mode_stochas == 0,
    r_con = 1:ntras; 
  elseif mode_stochas == 1,
  r_con = randperm(ntras); 
  elseif mode_stochas == 2,
  r_con = floor(rand(1,ntras)*ntras)+1; 
  end

  for i_k=1:numel(r_con); 
    k = r_con(i_k); 

    if mode_rec > 0 || mod(i_k,100) == 1, 
      
      nfeas = size(X_tra,1); 
      ntras = size(X_tra,2); 
      v_recon = (X_tra*alph)/(lam*ncons); 
      % tsassert( norm(v_recon-v_new) < 1e-10*nfeas*ntras ); 
      if ~( norm(v_recon-v_new) < 1e-5*nfeas*ntras ),
        keyboard(); tsassert(0); 
      end
      [tmp1,w_recon] = get_signreg2_d(v_recon,l_sgn);
      zs      = X_tra'*w_recon; 
      term1_p = lam*regfun_p(w_recon); 
      term2_p = sum(lossfun(zs))/ncons; 
      obj_p   = term1_p + term2_p; 

      term1_d = -lam*tmp1; 
      term2_d = -sum(lossfun_ast(-alph))/ncons; 
      obj_d   = term1_d + term2_d; 

      if mode_rec > 0,
        i_k_recfg = i_k;
      else
        i_k_recfg = (i_k-1)/100+1;      
      end
      fmat( i_k_recfg, iter ) = obj_p; 
      gmat( i_k_recfg, iter ) = obj_d; 
      if mode_rec > 1, 
        V_rec( 1:nfeas, i_k, iter ) = v_recon; 
        W_rec( 1:nfeas, i_k, iter ) = w_recon; 
        A_rec( 1:ncons, i_k, iter ) = alph; 
      end
      if verbose > 0, 
        fprintf('(%d,%d)a: f=%g, g=%g, i_k=%d\n', ...
                iter, i_k, obj_p, obj_d, i_k ); 
      end
      if i_k_recfg >= 2, 
        tsassert( gmat(i_k_recfg,iter)-gmat(i_k_recfg-1,iter) >= -1e-6 ); 
      end

    else
      % fprintf('.'); 
    end

    v_old     = v_new; 
    w_old     = w_new; 
    xk        = X_tra(:,k); 
    alphk_old = alph(k); 
    pnxk      = pownorms_xk(k); 
    nume1     = 1 - dot(w_old,xk) - alphk_old*m; 
    deno1     = pnxk*ilamn+m; 
    delalphk  = max(0,min(1,nume1./deno1 + alphk_old))-alphk_old; 
    alphk_new = alphk_old + delalphk; 
    tsassert( alphk_new >= -1e-8 );  
    tsassert( alphk_new <= 1+1e-8 );  
    alph(k)   = alphk_new; 
    v_new     = v_old + (delalphk*ilamn)*xk; 
    [tmp1,w_new] = get_signreg2_d(v_new,l_sgn);
    
  end
  
  if iter >= 2 && abs(fmat(1,iter)- gmat(1,iter))<thres_gap,
    finished = 1; 
  end
  if iter == niters,
    finished = 1; 
  end

end

if verbose > 0,fprintf('\n'); end
w_est = w_new; 
res.fmat = fmat(:,1:iter);
res.gmat = gmat(:,1:iter);
res.alph = alph; 
res.iter = iter; 
if mode_rec > 1, 
  res.W_rec = W_rec(:,:,1:iter); 
  res.V_rec = V_rec(:,:,1:iter); 
  res.A_rec = A_rec(:,:,1:iter); 
end



