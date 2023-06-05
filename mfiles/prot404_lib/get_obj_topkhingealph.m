function [obj_p,obj_d,res] = get_obj_topkhingealph( A_est, K_tra, y_tra, params_obj )
%
% [obj_p,obj_d,res] = get_obj_topkhingealph( A_est, K_tra, y_tra, params_obj )
%
fprintf('Invoke get_obj_topkhingealphK\n'); 
fprintf('instead of get_obj_topkhingealph.\n'); 
[obj_p,obj_d,res] = get_obj_topkhingealphK( A_est, K_tra, y_tra, params_obj );
