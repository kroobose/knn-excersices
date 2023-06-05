function canv1 = py_plot( canv1, x1s, y1s, sty1, param )
%
%
%

if nargin <= 4, 
  param.default = 1; 
end

argstr_plot = ''; 
if isfield( param, 'argstr_plot' )
  argstr_plot = param.argstr_plot; 
end

x1s = x1s(:)'; 
y1s = y1s(:)'; 
npts = numel(x1s); 
tsassert( numel(x1s) == npts ); 
tsassert( numel(y1s) == npts ); 
tsassert( ischar( sty1 ) ); 

i_dat  = numel(canv1.Xs); 

ln_out = sprintf('xs_tmp1 = Xs_plt[%d][0];',i_dat );
canv1.Xs{end+1}  = x1s;    i_dat=i_dat+1; 
canv1.lns{end+1} = ln_out; 
ln_out = sprintf('ys_tmp1 = Xs_plt[%d][0];',i_dat );i_dat=i_dat+1;
canv1.Xs{end+1}  = y1s;    i_dat=i_dat+1; 
canv1.lns{end+1} = ln_out; 
ln_out = sprintf('sty_tmp1 = ''%s'';',sty1); 
canv1.lns{end+1} = ln_out; 
if strcmp(argstr_plot,'') 
  ln_out = sprintf('plt.plot(xs_tmp1,ys_tmp1,sty_tmp1);'); 
else
  ln_out = sprintf('plt.plot(xs_tmp1,ys_tmp1,sty_tmp1,%s);',...
                   argstr_plot); 
end
canv1.lns{end+1} = ln_out; 





         

