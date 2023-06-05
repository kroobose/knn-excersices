function [w_est,res] ...
    = train_smhinge_kefreg( X_tra, lam, gam_sm, param )
% 
% 
% 
nfeas = size(X_tra,1); 
ntras = size(X_tra,2); 
tsassert( size(X_tra) == [nfeas,ntras] ); 
tsassert( isscalar(lam) ); 
lamn  = lam*ntras; ilamn = 1./lamn; ilamnn = ilamn./ntras;

if nargin <= 2, 
  param.default = 1;
end

niters = 1000; 
if isfield( param, 'niters' )
  niters = param.niters; 
end

nepochs = 1000; 
if isfield( param, 'nepochs' )
  nepochs = param.nepochs; 
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

verbose = 0; 
if isfield( param, 'verbose' )
  verbose = param.verbose; 
end

cvec  = param.cvec; 
kapo  = param.kapo;  ikapo = 1./kapo; %% kapo = kap + 1
tsassert( size(cvec) == [nfeas,1] ); 
pnxs  = csum(X_tra.^2)'; 
alph  = zeros(ntras,1); 
v_new = X_tra*alph*ilamn; 
l_n   = cvec.*v_new < 0;
l_nn  = ~l_n; 
w_new = v_new; w_new(l_n) = v_new(l_n).*ikapo; 
zs = X_tra'*w_new; 

lossfun     = @(z) smhingeloss(z,gam_sm);
lossfun_ast = @(alph) smhingeloss_ast(alph,gam_sm);
regfun_d    = @(v_new) get_kefreg_d( v_new, cvec, kapo ); 

iters_rec = ceil(logspace(0,log10(nepochs*ntras),100)); 
iters_rec = unique(iters_rec); 
i_iter_rec = 1; 

[~,w_new] = regfun_d(v_new); 
objs_primal = []; 
objs_dual   = []; 

if mode_rec > 0,
  ncons_recfg = ntras; 
else
  ncons_recfg = ceil(ntras/100);   
end
gs = zeros(1,numel(iters_rec)); 
fs = zeros(1,numel(iters_rec)); 

epoch = 0; finished = 0; 
while ~finished, 
  epoch = epoch + 1; 

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
    iter = (epoch-1)*ntras+i_k; 
    tsassert( ~any(isnan(w_new)) );
    
    if i_iter_rec <= numel(iters_rec) & iter == iters_rec(i_iter_rec)
      zs    = X_tra'*w_new; 
      reg1_d = regfun_d( v_new );            
      loss_d = -sum(lossfun_ast(-alph))./ntras; 
      obj_d  = -lam.*reg1_d + loss_d; 
      loss_p = sum(lossfun(zs))./ntras; 
      obj_p  = +lam.*reg1_d + loss_p; 

      fs( i_iter_rec ) = obj_p; 
      gs( i_iter_rec ) = obj_d; 
      if verbose > 0, 
        fprintf('(%d,%d): f=%g, g=%g, gap=%g\n', ...
                epoch, i_k, obj_p, obj_d, obj_p-obj_d ); 
      end
      if i_iter_rec >= 2, 
        tsassert( gs(i_iter_rec)-gs(i_iter_rec-1) >= -1e-6 ); 
      end
      i_iter_rec = i_iter_rec + 1; 

    else
      % fprintf('.'); 
    end

    v_old     = v_new; 
    w_old     = w_new; 
    xk        = X_tra(:,k); 
    alphk_old = alph(k); 
    pnxk      = pnxs(k); 
    nume1     = 1 - dot(w_old,xk) - alphk_old*gam_sm;
    deno1     = pnxk*ilamn+gam_sm;
    delalphk  = max(0,min(1,nume1./deno1 + alphk_old))-alphk_old;
    alphk_new = alphk_old + delalphk;
    tsassert( alphk_new >= -1e-8 );
    tsassert( alphk_new <= 1+1e-8 );
    alph(k)   = alphk_new;
    v_new     = v_old + (delalphk*ilamn)*xk; 
    [~,w_new] = regfun_d( v_new );            
    
    if i_iter_rec >= 2 && abs(fs(i_iter_rec-1)- gs(i_iter_rec-1))<thres_gap,
      finished = 1; break; 
    end
  end
  
  if iter == nepochs*ntras,
    finished = 1; 
  end

end

if verbose > 0,fprintf('\n'); end
w_est = w_new; 
res.fs        = fs(:,1:i_iter_rec-1);
res.gs        = gs(:,1:i_iter_rec-1);
res.iters_rec = iters_rec(1:i_iter_rec-1); 
res.alph = alph; 
res.iter = iter; 
return; 
