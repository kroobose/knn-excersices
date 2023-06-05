function [obj_p,obj_d,res] = get_obj_sofmx_sgnreg2( A_new, X_tra, y_tra, params_obj )
%
%
%
lam   = params_obj.lam; 
cmat  = params_obj.cmat; 
Hs = []; 
if isfield( params_obj, 'Hs' )
  Hs = params_obj.Hs; 
end
rs_ct = []; 
if isfield( params_obj, 'rs_ct' )
  rs_ct = params_obj.rs_ct; 
end

[nfeas,ntras] = size( X_tra ); 
ncts = size( A_new, 1 ); 
tsassert( size(A_new) == [ncts,ntras] ); 
tsassert( size(y_tra) == [ntras,1] ); 
lamn  = lam.*ntras; ilamn = 1./lamn; 

fh_sofmx_p = @(sdfmat)clsume(sdfmat)'; 
fh_sofmx_d = @(A)csum(A.*log(A))'; 
fh_pi      = @(V)V + cmat.*max(0,-cmat.*V); 
fh_pi2     = @(V)V + cmat(:).*max(0,-cmat(:).*V); 

if numel(Hs) == 0, 
  Hs = zeros(ncts,ncts,ncts); 
  for ct1=1:ncts
    e_y  = unitvec(ct1,ncts); 
    H1   = eye(ncts) - e_y*ones(1,ncts); 
    Hs(:,:,ct1) = H1; 
  end
end

if numel(rs_ct) == 0, 
  rs_ct = cell(1,ncts); 
  for ct1=1:ncts
    rs_ct{ct1} = find(y_tra==ct1); 
  end
end

tmp1 = zeros( nfeas, ncts, ncts ); 
for ct1=1:ncts
  r_ct  = rs_ct{ct1}; 
  HA_ct = Hs(:,:,ct1)*A_new(:,r_ct); 
  tmp1(:,:,ct1) = X_tra(:,r_ct)*HA_ct'; 
end
V_new = sum(tmp1,3).*ilamn; 
W_new = fh_pi(V_new); 

if 0,
  X_big = zeros( nfeas*ncts, ncts, ntras ); 
  for i_tra=1:ntras
    e_y   = unitvec(y_tra(i_tra),ncts); 
    term1 = eye(ncts) - e_y*ones(1,ncts); 
    tmp1  = kron(term1,X_tra(:,i_tra)); 
    X_big(:,:,i_tra) = tmp1; 
  end

  vmat_new = zeros( nfeas*ncts, ntras ); 
  for i_tra=1:ntras
    vmat_new(:,i_tra) = X_big(:,:,i_tra)*A_new(:,i_tra).*ilamn; 
  end
  v_new = rsum(vmat_new); 
  w_new = fh_pi2(v_new); 

  sdfmat = zeros( ncts, ntras ); 
  for i_tra=1:ntras
    sdfmat(:,i_tra) = X_big(:,:,i_tra)'*w_new; 
  end
else
  scomat = W_new'*X_tra; 
  sdfmat = zeros( ncts, ntras ); 
  for ct1=1:ncts
    r_ct = rs_ct{ct1}; 
    H1   = Hs(:,:,ct1); 
    sdfmat(:,r_ct) = H1'*scomat(:,r_ct); 
  end
end

loss1s_p = fh_sofmx_p( sdfmat ); 
loss1s_d = -fh_sofmx_d( -A_new ); 
reg_p = 0.5*lam*norm( W_new(:) ).^2;
reg_d = -reg_p;
obj_p = reg_p + sum(loss1s_p)./ntras;
obj_d = reg_d + sum(loss1s_d)./ntras;

res.loss1s_p = loss1s_p; 
res.loss1s_d = loss1s_d; 
res.reg_p = reg_p; 
res.reg_d = reg_d; 
