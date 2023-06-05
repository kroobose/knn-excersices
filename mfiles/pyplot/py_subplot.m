function canv1 = py_subplot( canv1, nrows, ncols, i_fig )
%
%
%
ln_out = sprintf('plt.subplot(%d,%d,%d);', nrows, ncols, i_fig ); 
canv1.lns{end+1} = ln_out; 
ln_out = sprintf('plt.hold(True);'); 
canv1.lns{end+1} = ln_out; 

