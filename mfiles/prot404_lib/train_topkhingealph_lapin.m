function [A_est,res] ...
    = train_topkhingealph_lapin( K_tra, y_tra, lam, param )
%
% This function reproduces the Lapin's buggy theories
% for topk_hinge_alpha. 
%

k_tk  = 1; 
if isfield( param, 'k_tk' ),
  k_tk = param.k_tk;
end

ncts  = max(y_tra);
if isfield( param, 'ncts' ),
  ncts = param.ncts; 
end

niters = 500; 
if isfield( param, 'niters' )
  niters = param.niters; 
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

thres_gap = 1e-5; 
if isfield( param, 'thres_gap' ),
  thres_gap = param.thres_gap;
end


y_tra = y_tra(:); ntras = numel(y_tra); 
tsassert( size(K_tra)  == [ntras,ntras] ); 
tsassert( size(y_tra)  == [ntras,1] ); 

A_init = zeros(ncts,ntras);
if isfield( param, 'A_init' )
  A_init = param.A_init;
  tsassert( size(A_init) == [ncts,ntras] );
end

lamn  = lam*ntras; ilamn = 1./lamn; 
em = zeros(ncts,1); em(ncts) = 1; 
inds_y = sub2ind( [ncts,ntras], y_tra', 1:ntras ); 
params_obj.k_tk = k_tk; params_obj.lam = lam; 
params_obj.computing_objp_buggy = 1; 
H_qp  = diag( [ones(1,ncts),0] ); 
A_eq = [ones(1,ncts),0;zeros(1,ncts),1]; b_eq = [0;0]; 
A1_ineq = [-eye(ncts)+ones(ncts)/k_tk, zeros(ncts,1)]; 
A2_ineq = [eye(ncts), zeros(ncts,1)]; 
A3_ineq = [-ones(1,ncts), 0]; 
A_ineq = [A1_ineq;A2_ineq;A3_ineq]; 
A_ineq(:,end-1:end) = A_ineq(:,end:-1:end-1); 
b_ineq = rsum(A_ineq)*0.0; b_ineq(end) = 1; 

A_est = A_init; 
gmat = zeros(ntras,niters);
fmat = zeros(ntras,niters);
fmat_bug = zeros(ntras,niters);

iter = 0; finished = 0;
while ~finished,
  iter = iter + 1;

  if mode_stochas == 0,
    r_con = 1:ntras;
  elseif mode_stochas == 1,
    r_con = randperm(ntras);
  end

  for i0_k=1:numel(r_con)
    i_k = r_con(i0_k);

    if mode_rec > 0 || i0_k == 1,
      [obj_p,obj_d,res_obj] ...
          = get_obj_topkhingealph( A_est, K_tra, y_tra, params_obj );
      fmat( i0_k, iter ) = obj_p; gmat( i0_k, iter ) = obj_d;
      fmat_bug( i0_k, iter ) = res_obj.objp_buggy; 
      if verbose > 0,
        fprintf('(%d,%d)a: f=%g, g=%g\n', iter, i0_k, obj_p, obj_d );
      end
      if i0_k >= 2,
        tsassert( gmat(i0_k,iter)-gmat(i0_k-1,iter) >= -1e-6 );
      end
    else
      % fprintf('.');
    end
    
    A_bar = A_est; A_bar(:,i_k) = 0; 
    y_i   = y_tra(i_k); 
    K_ii  = K_tra(i_k,i_k); 
    kveci = K_tra(:,i_k); 
    zbar  = A_bar*kveci./lamn; 
    zbar([ncts,y_i]) = zbar([y_i,ncts]); 
    f_qp  = [(zbar-em)*lamn./K_ii; 0]; 
    [albem,~,exitflag,output] ...
        = cplexqp( H_qp, f_qp, A_ineq, b_ineq, A_eq, b_eq ); 
    alphi = albem(1:ncts);     
    alphi([ncts,y_i]) = alphi([y_i,ncts]); 
    A_est(:,i_k) = alphi; 
    
  end
 if iter >= 2 && abs(fmat(1,iter)- gmat(1,iter-1))<thres_gap,
    finished = 1;
  end
  if iter == niters,
    finished = 1;
  end

end

if verbose > 0,fprintf('\n'); end
res.fmat = fmat;
res.fmat_bug = fmat_bug;
res.gmat = gmat;
res.A_est = A_est; 
res.iter = iter;
res.dualgap = fmat(1,iter)- gmat(1,iter-1);

