function plot_X_cts( X_tra, cts_tra )
%
%
%

cts_tra(cts_tra==-1)=2; 

ncts = max(cts_tra);
stys = {'k.','r^','bv','g<','m>','cs','yd',...
        'rv','b<','g>','ms','cd','y^'}; 
for ct=1:ncts
  l_ct = cts_tra == ct; 
  sty  = stys{ct+1}; 
  plt1 = plot( X_tra(1,l_ct), X_tra(2,l_ct), sty ); 
  clr = get( plt1, 'Color' ); 
  set( plt1, 'MarkerFaceColor', clr ); 
  set( plt1, 'MarkerEdgeColor', 'none' ); 
end

