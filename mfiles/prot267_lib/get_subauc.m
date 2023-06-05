function ret = get_subauc( curve, dom )
%
% ret = get_subauc( curve, dom )
% 
%   curve : npts x 2  
%           curve must be non-decreasing. 
%   dom :   1 x 2
% 
% This function computes the area under curve of
% the domain
%
%   dom(1) <= x <= dom(2)
%

tsassert( issorted( curve(:,1) ) ); 
tsassert( issorted( curve(:,2) ) ); 

epsi = 1e-5; 
dom = dom(:)'; 
tsassert( size(curve,2) == 2 ); 
tsassert( size(dom) == [1,2] ); 
x_st = dom(1)+epsi; y_st = get_y_on_auccurve( x_st, curve ); 
x_en = dom(2)-epsi; y_en = get_y_on_auccurve( x_en, curve ); 

curve = [ curve; x_st, y_st; x_en, y_en ]; 
[tmp1,r_tmp1] = sort(curve(:,1)); 
curve = curve(r_tmp1,:); 
l_tmp1 = x_st <= curve(:,1) & x_en >= curve(:,1); 
curve = curve(l_tmp1,:); 

npts = size( curve, 1 ); 
ret = 0; 
for i1=1:(npts-1)
  x1 = curve(i1,1); x2 = curve(i1+1,1); 
  y1 = curve(i1,2); y2 = curve(i1+1,2); 
  ret = ret + (x2-x1)*(y1+y2)*0.5; 
end


