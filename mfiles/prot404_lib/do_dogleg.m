function [pk,tau] = do_dogleg( fh, xk, Mk )
%
%
%

[fval,g,J] = fh( xk ); 
J = reshape( J, 2, 2 ); 

JTg  = J'*g; 
JJTg = J*JTg; 
norm_JTg  = norm(JTg); 
norm_JJTg = norm(JJTg); 
tauk = Mk / norm_JTg; 
tauk = min( tauk, (norm_JTg/norm_JJTg).^2 ); 
pkc  = -tauk*JTg; 

if tauk == Mk / norm_JTg, 
  pk = pkc; tau = 0.0; 
  return; 
end

pkS  = -(J \ g); 
p1   = pkc; p2 = pkS-pkc; 
p12 = dot(p1,p2); p11 = dot(p1,p1); p22 = dot(p2,p2); 
tau = (-p12 + sqrt( p12*p12 - p22*(p11-Mk*Mk) ))/p22; 
tau = min( tau, 1.0 ); 
pk  =  p1 + p2*tau; 

