function canv1 = py_yticks( canv1, ys, lbls )
%
%
%
ys = ys(:)'; 
npts = numel(ys); 

i_dat  = numel(canv1.Xs); 
ln_out = sprintf('ys_tmp1 = Xs_plt[%d][0];',i_dat );
canv1.Xs{end+1}  = ys;    i_dat=i_dat+1; 
canv1.lns{end+1} = ln_out; 

if nargin == 2,

  ln_out = sprintf('plt.yticks( ys_tmp1 );'); 
  canv1.lns{end+1} = ln_out; 

elseif nargin == 3,

  tsassert( numel(ys)   == npts ); 
  tsassert( numel(lbls) == npts ); 
  tsassert( iscellstr(lbls) ); 
  
  ln_out = sprintf('lbls = (''%s''',lbls{1}); 
  for i_lgnd=2:numel(lbls)
    ln_out = sprintf('%s,''%s''',ln_out,lbls{i_lgnd}); 
  end
  ln_out = sprintf('%s);',ln_out); 
  canv1.lns{end+1} = ln_out; 

  ln_out = sprintf('plt.yticks( ys_tmp1, lbls );'); 
  canv1.lns{end+1} = ln_out; 

else
  tsassert(0);
end



