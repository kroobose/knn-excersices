function w = train_l2lr( X_tra, y_tra, lam, v )  
%
% loss(x,y;w) = log(1+exp(<w,x>))-y*<w,x>,
% Loss(X,y;lam,w) = sum_{i} lam(i) * loss(X(:,i),y(i);w),  
% reg(w)    = 0.5*||w-v||^2. 
%
% y_tra(i) in {0,1}
%

ndims   = size( X_tra, 1 ); 
ntras   = size( X_tra, 2 ); 
y_tra   = y_tra(:); 
lam     = lam(:); 
v       = v(:); 
tsassert( numel( y_tra ) == ntras ); 
tsassert( numel( lam ) == ntras ); 
tsassert( numel( v ) == ndims );
tsassert( min(y_tra) == 0 ); 

w_new   = v;
obj_new = get_obj_l2lr( w_new, X_tra, y_tra, lam, v ); 
iter = 0; finished = 0; 
while ~finished
  iter  = iter + 1; 
  % fprintf('iter=%03d, obj=%g\n', iter, obj_new ); 
  w     = w_new; 
  obj   = obj_new; 
  updated = 0; 
  pp     = exp( X_tra'*w ); pp = pp./(1+pp); 
  ptil   = lam .* pp .* (1-pp); 
  hess   = mtimes_diag(X_tra,sqrt(ptil)); hess = hess*hess' + eye(ndims); 
  grad   = X_tra*(lam.*(pp-y_tra)) + w - v; 
  del_w  = hess\grad; 
  lamt  = 2; 
  while ~updated,
    lamt    = 0.5*lamt; 
    w_new   = w - lamt*del_w; 
    obj_new = get_obj_l2lr( w_new, X_tra, y_tra, lam, v ); 
    if obj_new < obj,
      updated = 1; 
    end
    if lamt < 1e-5, 
      updated = 1; 
    end
  end
  if lamt < 1e-5, 
    finished = 1; 
  end
end
