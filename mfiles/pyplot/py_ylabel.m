function canv1 = py_ylabel( canv1, lbl )
%
%
%
tsassert( ischar(lbl) ); 
ln_out = sprintf('plt.ylabel(''%s'');', lbl); 
canv1.lns{end+1} = ln_out; 


