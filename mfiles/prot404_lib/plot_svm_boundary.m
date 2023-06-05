function plot_svm_boundary( w_svm, b_svm, xlim1, ylim1, param )
%
% Plot the line: <w_svm,x> + b_svm = 0. 
%
param.default = 1; 

margin = 1; 
if isfield( param, 'margin' )
  margin = param.margin; 
end
clr = [0, 0, 0]; 
if isfield( param, 'clr' )
  clr = param.clr; 
end

if abs(w_svm(1)) > abs(w_svm(2)), 
  x2s = [ylim1(1),ylim1(2)];  
  x1s = - (w_svm(2)*x2s+b_svm)/w_svm(1);
  plt1 = plot( x1s, x2s, 'k-' ); 
    set( plt1, 'Color', clr ); 
  set( plt1, 'LineWidth', 3 ); 
  if margin > 0,
    x1s = - (w_svm(2)*x2s+b_svm+margin)/w_svm(1); 
    plt1 = plot( x1s, x2s, 'k:' ); 
    set( plt1, 'Color', clr ); 
    x1s = - (w_svm(2)*x2s+b_svm-margin)/w_svm(1); 
    plt1 = plot( x1s, x2s, 'k:' ); 
    set( plt1, 'Color', clr );     
  end
else
  x1s = [xlim1(1),xlim1(2)];  
  x2s = - (w_svm(1)*x1s+b_svm)/w_svm(2); 
  plt1 = plot( x1s, x2s, 'k-' ); 
  set( plt1, 'Color', clr ); 
  set( plt1, 'LineWidth', 3 ); 
  if margin > 0,
    x2s = - (w_svm(1)*x1s+b_svm+margin)/w_svm(2); 
    plt1 = plot( x1s, x2s, 'k:' ); 
    set( plt1, 'Color', clr ); 
    x2s = - (w_svm(1)*x1s+b_svm-margin)/w_svm(2); 
    plt1 = plot( x1s, x2s, 'k:' ); 
    set( plt1, 'Color', clr ); 
  end
end

