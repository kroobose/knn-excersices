function Y = logdet( X )
% Y = logdet( X )
% return a log determinant of X
[d err] = chol(X);
if err
  Y = -inf;
else
  d = diag(d);
  Y = sum( log(d) ) *2;
end

