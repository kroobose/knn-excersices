function ret = smhingeloss(z,m)
%
% (1/m)-smooth hinge loss
%

l1 = 1 - m >= z; 
l2 = ~l1 & (1 >= z); 
term1 = l1.*(1-z-m*0.5); 
term2 = l2.*(0.5./m.*(z-1).^2); 
ret = term1 + term2; 



