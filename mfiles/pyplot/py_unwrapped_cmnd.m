function canv1 = py_unwrapped_cmnd( canv1, lns )
%
%
%
if iscellstr( lns )
  for i_ln=1:numel(lns)
    canv1.lns{end+1} = lns{i_ln}; 
  end
elseif ischar( lns )
  canv1.lns{end+1} = lns; 
else
  tsassert(0); 
end

  
