%
%
%
function tsassert( x )

if ( ~all(vec(x)) ) 
  keyboard(); 
  error('Assertion error!');
end




