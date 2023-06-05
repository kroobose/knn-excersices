function canv1 = py_bar( canv1, xs, Y, mode_bar, param )
%
%
%

if nargin <= 4, 
  param.default = 1; 
end

lgnds = cell(0,0);  
if isfield( param, 'lgnds' )
  lgnds = param.lgnds; 
end

xs = xs(:)'; 
Y  = Y; 
npts  = size(Y,1); 
nbars = size(Y,2); 
tsassert( numel(xs) == npts ); 
tsassert( strcmp( mode_bar, 'stacked' ) ); 
if ~strcmp(lgnds,'') 
  tsassert( nbars == 1 ); %% Not implemented yet for nbars >= 2. 
end

i_x  = numel(canv1.Xs); 

canv1.Xs{end+1} = xs; 
for i_bar=1:nbars
  canv1.Xs{end+1} = Y(:,i_bar)'; 
end

canv1.lns{end+1} = sprintf('i_x   = %d;',i_x); 
canv1.lns{end+1} = sprintf('nbars = %d;',nbars); 
canv1.lns{end+1} = 'clrmat = np.zeros( (nbars, 3) );'; 
canv1.lns{end+1} = 'for i_bar in range( 0, nbars ):';
canv1.lns{end+1} = '    clrmat[i_bar][0] = (i_bar+1.0)/(nbars+1.0);';
canv1.lns{end+1} = '    clrmat[i_bar][1] = (i_bar+1.0)/(nbars+1.0);';
canv1.lns{end+1} = '    clrmat[i_bar][2] = (i_bar+1.0)/(nbars+1.0);';
canv1.lns{end+1} = 'xs_tmp1 = Xs_plt[i_x][0];';
canv1.lns{end+1} = 'nxs     = len(xs_tmp1);';
canv1.lns{end+1} = 'Ys_tmp1 = [];';
canv1.lns{end+1} = 'Ys_tmp1.append(np.zeros((1,nxs)));';
canv1.lns{end+1} = 'width = np.min(xs_tmp1[1:]-xs_tmp1[:-1])*0.8;'; 
canv1.lns{end+1} = 'xs_tmp1 = Xs_plt[i_x][0]-width*0.5;';
ln_tmp1 = ''; 
ln_tmp1 = sprintf('%splt.bar( xs_tmp1, Xs_plt[i_x+1][0]', ln_tmp1); 
ln_tmp1 = sprintf('%s, width, color=clrmat[0]',           ln_tmp1); 
if ~strcmp( lgnds, '' )
  ln_tmp1 = sprintf('%s, label="%s"', ln_tmp1, lgnds{1}); 
end
ln_tmp1 = sprintf( '%s);', ln_tmp1 ); 
canv1.lns{end+1} = ln_tmp1; 
canv1.lns{end+1} = 'for i_bar in range( 1, nbars ): # i_y in range( i_x+2, i_x+nbars+1 ):';
canv1.lns{end+1} = '    plt.bar( xs_tmp1, Xs_plt[i_x+i_bar+1][0], width, bottom=Xs_plt[i_x+i_bar][0], color=clrmat[i_bar] );';

