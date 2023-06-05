function [xk,fval,res] = ts_fsolve( fh, x0, param )
%
% Trust region dogleg method. 
%

if nargin == 2,
  param.default = 1; 
end

xk = x0; 
M0 = 2.0; 
Mk = 1.0; 
eta = 0.125; 
iter_mx = 100; 
epsi = 1e-5; 
mode_rec = 0; 

if isfield( param, 'iter_mx' )
  iter_mx = param.iter_mx; 
end

if isfield( param, 'epsi' )
  epsi = param.epsi; 
end

if isfield( param, 'mode_rec' )
  mode_rec = param.mode_rec; 
end

fks_loc = []; xks_loc = []; 

for iter=1:iter_mx

  [gk,Jk] = fh( xk ); Jk = reshape(Jk,2,2); 
  fk = 0.5*sum(gk.^2); 
  pk = do_dogleg_test156( xk, Mk ); 
  gk_new = fh( xk+pk ); 
  fk_new = 0.5*sum(gk_new.^2); 
  mk = fk; 
  mk_new = 0.5 * norm(gk+Jk*pk).^2; 

  if mode_rec >= 1,
    fks_loc(iter) = fk; xks_loc = [xks_loc,xk]; 
  end
  
  rhok   = (fk-fk_new)/(mk-mk_new); 
  if rhok < 0.25, 
    Mk = 0.25 * norm(pk); 
  elseif rhok > 0.75 && norm(pk) <= Mk,
    Mk = min( Mk*2, M0 ); 
  else
    Mk = Mk;
  end
  if rhok > eta, 
    xk = xk + pk; 
  else
    xk = xk;
  end
  
  if fk < epsi,
    break;
  end
  
end

fval = fk; 
res.fks_loc = fks_loc; 
res.xks_loc = xks_loc; 
