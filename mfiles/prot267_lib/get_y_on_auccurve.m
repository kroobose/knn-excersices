function y_cur = get_y_on_auccurve( x_cur, curve )
%
% y_cur = get_y_on_auccurve( x_cur, curve )
% 
% x_cur : vector
% curve : npts x 2  
%         curve must be non-decreasing. 
%
tsassert( size(curve,2) == 2 ); 
if isscalar( x_cur )
  if ( x_cur <= curve(1,1) )
    y_cur = curve(1,1); 
  elseif ( x_cur >= curve(end,1) )
    y_cur = curve(end,1); 
  else
    i_lft = find( x_cur >= curve(:,1) ); i_lft = i_lft(end); 
    x_lft = curve(i_lft,1); y_lft = curve(i_lft,2); 
    i_rgt = i_lft + 1; 
    x_rgt = curve(i_rgt,1); y_rgt = curve(i_rgt,2); 
    % find alph s.t. x_cur = x_lft*(1-alph) + x_rgt*alph; 
    alph  = (x_cur - x_lft) / (x_rgt - x_lft ); 
    y_cur = y_lft*(1-alph) + y_rgt*alph; 
  end
else
  y_cur = zeros(size(x_cur)); 
  for i1=1:numel(x_cur)
    y_cur(i1) = get_y_on_auccurve( x_cur(i1), curve ); 
  end
end
