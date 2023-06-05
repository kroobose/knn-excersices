function obj = get_obj_l2lr( w, X_tra, y_tra, lam, v )  

ndims   = size( X_tra, 1 ); 
ntras   = size( X_tra, 2 ); 
y_tra   = y_tra(:); 
lam     = lam(:); 
v       = v(:); 
tsassert( numel( y_tra ) == ntras ); 
tsassert( numel( lam ) == ntras ); 
tsassert( numel( v ) == ndims );
tsassert( min(y_tra) == 0 ); 

loss  = get_loss_lr( w, X_tra, y_tra, lam );
reg   = 0.5*dot(w-v,w-v); 
obj   = loss + reg; 

