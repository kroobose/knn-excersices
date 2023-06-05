function [W_est,res] ...
    = train_sofmx_sgnreg2_proxsdca( X_tra, y_tra, lam, param )
% get_obj_sofmx_sgnreg2
  
param.default = 1; 

[nfeas,ntras] = size( X_tra ); 
ncts = max(y_tra); 
tsassert( y_tra >= 0 ); 
lamn  = lam.*ntras; ilamn = 1./lamn; 

cmat = false( nfeas, ncts ); 
if isfield( param, 'cmat' )
  cmat = param.cmat;
end

nepochs = 1000;
if isfield( param, 'nepochs' )
  nepochs = param.nepochs;
end
tsassert( ~isfield( param, 'niters' ) );

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

Hs = zeros(ncts,ncts,ncts); 
for ct1=1:ncts
  e_y  = unitvec(ct1,ncts); 
  H1   = eye(ncts) - e_y*ones(1,ncts); 
  Hs(:,:,ct1) = H1; 
end

rs_ct = cell(1,ncts); 
for ct1=1:ncts
  rs_ct{ct1} = find(y_tra==ct1); 
end

fh_sofmx_p = @(sdfmat)clsume(sdfmat)'; 
fh_sofmx_d = @(A)csum(A.*log(A))'; 
fh_pi      = @(V)V + cmat.*max(0,-cmat.*V); 

iters_rec = ceil(logspace(0,log10(nepochs*ntras),100));
iters_rec = unique(iters_rec);
i_iter_rec = 1;

A_new = -ones( ncts, ntras )./ncts; 
tmp1 = zeros( nfeas, ncts, ncts ); 
for ct1=1:ncts
  r_ct  = rs_ct{ct1}; 
  HA_ct = Hs(:,:,ct1)*A_new(:,r_ct); 
  tmp1(:,:,ct1) = X_tra(:,r_ct)*HA_ct'; 
end
V_new = sum(tmp1,3).*ilamn; 
W_new = fh_pi(V_new); 

params_obj.lam  = lam;
% params_obj.gam  = gam;
params_obj.cmat = cmat;
params_obj.Hs = Hs; 
params_obj.rs_ct = rs_ct; 

fs = zeros(1,numel(iters_rec));
gs = zeros(1,numel(iters_rec));

epoch = 0; finished = 0;
while ~finished,
  epoch = epoch + 1;
  tsassert( ~any(isnan(W_new)) );  
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
    if i_iter_rec <= numel(iters_rec) & iter == iters_rec(i_iter_rec)
      [obj_p,obj_d,res0] = get_obj_sofmx_sgnreg2( A_new, X_tra, y_tra,...
                                                         params_obj );
      fs( i_iter_rec ) = obj_p;
      gs( i_iter_rec ) = obj_d;
      if verbose > 0,
        fprintf('(%d,%d)a: f=%g, g=%g, gap=%g\n', ...
                epoch, i_k, obj_p, obj_d, obj_p-obj_d );
      end
      if i_iter_rec >= 2,
        if ~( gs(i_iter_rec)-gs(i_iter_rec-1) >= -1e-6 ),
          keyboard(); tsassert(0); 
        end
      end
      i_iter_rec = i_iter_rec + 1;
      
    end
    V_old = V_new;      W_old = W_new;      
    xk    = X_tra(:,k); yk    = y_tra(k);   Hk    = Hs(:,:,yk); 
    zk    = Hk'*W_old'*xk; 
    alphk = A_new(:,k);  
    gradk = exp( zk - clsume( zk ) ); 
    uk    = -gradk; 
    qvec  = uk - alphk; 
    % pnq_l2 = sum(qvec.^2); 
    pnq_l1 = sum(abs(qvec)).^2; 
    phik_p = fh_sofmx_p(zk); 
    phik_d = fh_sofmx_d(-alphk);  
    nume1  = phik_p + phik_d + dot(zk,alphk) + 0.5.*pnq_l1; 
    deno1  = pnq_l1 + ilamn.*(sum(xk.^2).*sum((Hk*qvec).^2)); 
    tsassert( deno1 > 0 ); 
    s_ub = 0.0;    r_p = find(qvec > 0);     
    if numel(r_p) > 0,    
      epsi = 1e-3; sv = -(alphk(r_p)+epsi)./qvec(r_p); 
      s_ub = min(1,min(sv)); tsassert( s_ub >= -1e-10 ); 
      s_ub = max(0,s_ub); 
    end
    s_opt  = nume1./deno1; s_opt = max(0,min(s_ub,s_opt)); 
    dalk_new = s_opt.*qvec; 
    A_new(:,k) = A_new(:,k) + dalk_new; 
    V_new = V_old + xk*dalk_new'*Hk'.*ilamn;     
    W_new = fh_pi(V_new); 
    tsassert( ~isnan(W_new) ); 
  
    if i_iter_rec >= 2 && abs(fs(i_iter_rec-1)- gs(i_iter_rec-1))<thres_gap,
      finished = 1; break;
    end
  
  end
  
  if epoch == nepochs, 
    break; 
  end
  
end

if verbose > 0,fprintf('\n'); end
W_est = W_new;
res.fs        = fs(:,1:i_iter_rec-1);
res.gs        = gs(:,1:i_iter_rec-1);
res.gap       = fs(i_iter_rec-1)-gs(i_iter_rec-1); 
res.iters_rec = iters_rec(1:i_iter_rec-1);
res.A_est = A_new;
res.iter = iter;
res.V_est = V_new; 
return;

