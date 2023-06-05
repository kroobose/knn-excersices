function [obj_primal,obj_dual,res] = ...
    get_obj_fromesvm1( w_new, alph, X, cs, w0, param )

v_new      = X*alph; 
xi         = max( 1-X'*w_new, 0 ); 
obj_primal = 0.5*dot(w_new-w0,w_new-w0) + dot(cs,xi); 
beta       = max(-w0-v_new,0); 

obj_dual   = 0.0; 
obj_dual   = obj_dual -0.5*dot(v_new,v_new); 
obj_dual   = obj_dual - dot(alph,X'*(beta+w0)-1); 
obj_dual   = obj_dual - dot(beta,w0); 
obj_dual   = obj_dual -0.5*dot(beta,beta); 

res.xi   = xi; 
res.beta = beta; 

