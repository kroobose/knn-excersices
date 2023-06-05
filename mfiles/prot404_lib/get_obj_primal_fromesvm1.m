function [obj_primal,res] = ...
    get_obj_primal_fromesvm1( w_new, X, cs, w0 )

ndims  = size(X,1); 
npatts = size(X,2); 
cs     = cs(:); 
w_new  = w_new(:); 
w0     = w0(:); 
tsassert( numel(w_new) == ndims ); 
tsassert( numel(w0)    == ndims ); 
tsassert( numel(cs)    == npatts ); 

xi         = max( 1-X'*w_new, 0 ); 
obj_primal = 0.5*dot(w_new-w0,w_new-w0) + dot(cs,xi); 
res.xi   = xi; 


