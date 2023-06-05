function curve_ret = get_ave_auccurve( curves )

x_ret = []; 
ncurves = length(curves); 
for i_curve=1:ncurves
  curve  = curves{i_curve}; 
  x_ret = [x_ret,curve(:,1)']; 
end
x_ret = unique( x_ret ); 
npts_all = length(x_ret); 
Y_all    = zeros( ncurves, npts_all ); 
for i_curve=1:ncurves
  Y_all(i_curve,:) = get_y_on_auccurve( x_ret, curves{i_curve} ); 
end
y_ret = cmean(Y_all); 
curve_ret = [ x_ret; y_ret]';  
