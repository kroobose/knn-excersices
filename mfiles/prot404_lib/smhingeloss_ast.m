function ret = smhingeloss_ast(alph,m)

l1 = alph >= -1; 
l2 = alph <= 0;
l3 = l1&l2; 
ret = l3.*(alph+0.5*m*alph.^2) + ~l3*1e+300; 


