function canv1 = py_xlabel( canv1, lbl )
%
%
%
tsassert( ischar(lbl) ); 
ln_out = sprintf('plt.xlabel(''%s'');', lbl); 
canv1.lns{end+1} = ln_out; 


