function tsassert_zro( A, epsi )
%
%
%
if nargin <= 1,
  epsi = 1e-12; 
end

tsassert( max(abs(A(:))) < epsi ); 