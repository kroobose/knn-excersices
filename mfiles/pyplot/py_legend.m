function canv1 = py_legend( canv1, lgnds )
%
%
%
if iscellstr(lgnds)
  ln_out = sprintf('lgnds = (''%s''',lgnds{1}); 
  for i_lgnd=2:numel(lgnds)
    ln_out = sprintf('%s,''%s''',ln_out,lgnds{i_lgnd}); 
  end
  ln_out = sprintf('%s);',ln_out); 
  canv1.lns{end+1} = ln_out; 
elseif ischar(lgnds)
  ln_out = sprintf('lgnds = (''%s''',lgnds(1,:)); 
  for i_lgnd=2:size(lgnds,1)
    ln_out = sprintf('%s,''%s''',ln_out,lgnds(i_lgnd,:)); 
  end
  ln_out = sprintf('%s);',ln_out); 
  canv1.lns{end+1} = ln_out; 
else
  tsassert(0); 
end
ln_out = sprintf('plt.legend( lgnds );'); 
canv1.lns{end+1} = ln_out; 


