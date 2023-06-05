function canv1 = py_ylim( canv1, ylim1 )
%
%
%
ylim1 = ylim1(:)'; 
tsassert( numel(ylim1) == 2 ); 
ln_out = sprintf('plt.ylim((%g,%g));', ylim1(1),ylim1(2) ); 
canv1.lns{end+1} = ln_out; 


