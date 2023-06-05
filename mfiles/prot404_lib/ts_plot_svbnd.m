%
% canv1 = ts_plot_svbnd( canv1, w_lab, b_lab, t )
%
function canv1 = ts_plot_svbnd( canv1, w_lab, b_lab, param )

if nargin <= 3,
  param.default = 1;
end

if ~isfield( param, 'rho' )
  param.rho = 1;
end

if ~isfield( param, 'waku' )
  param.waku = [2 -2; -2 -2; -2 2; 2 2]';
end

rho  = param.rho;
waku = param.waku;

X_tmp = pl_get_line_in_poly( waku, w_lab, b_lab );
if ( size(X_tmp,2) > 0 )
[canv1,plt] = ts_plot( canv1, X_tmp(1,:), X_tmp(2,:), 'g-' );
% canv1     = ts_set( canv1, plt, 'Color', [0 1 0] );
canv1     = ts_set( canv1, plt, 'Color', [0.5 0.5 0.5] );
else
  size(X_tmp)
end

X_tmp = pl_get_common_region_of_poly_and_half_space( waku, w_lab, ...
						  b_lab-rho );
if ( size(X_tmp,2) > 0 )
  [canv1,fll] = ts_fill( canv1, X_tmp(1,:), X_tmp(2,:), 'r' );
  % canv1 = ts_set( canv1, fll, 'Color',     [1 0.75 0.75] );
  canv1 = ts_set( canv1, fll, 'EdgeColor', [0 0 0] );
  canv1 = ts_set( canv1, fll, 'FaceColor', [1 0.75 0.75] );
  canv1 = ts_set( canv1, fll, 'LineStyle', 'none' );
  X_tmp = pl_get_common_region_of_poly_and_half_space( waku, -w_lab, ...
						  -b_lab-rho );
else
  size(X_tmp)
end
if ( size(X_tmp,2) > 0 )
  [canv1,fll] = ts_fill( canv1, X_tmp(1,:), X_tmp(2,:), 'b' );
  % canv1 = ts_set( canv1, fll, 'Color',     [0.75 0.75 1] );
  canv1 = ts_set( canv1, fll, 'EdgeColor', [0 0 0] );
  canv1 = ts_set( canv1, fll, 'FaceColor', [0.75 0.75 1] );
  canv1 = ts_set( canv1, fll, 'LineStyle', 'none' );
else
  size(X_tmp); 
end
