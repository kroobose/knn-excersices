function loss = get_loss_lr( w, X_tra, y_tra, lam )  
%
%
%

ndims   = size( X_tra, 1 ); 
ntras   = size( X_tra, 2 ); 
y_tra   = y_tra(:); 
lam     = lam(:); 
tsassert( numel( y_tra ) == ntras ); 
tsassert( numel( lam ) == ntras ); 

score = X_tra'*w; 
loss  = dot( lam, log(1+exp(score)) - score.*y_tra ); 

