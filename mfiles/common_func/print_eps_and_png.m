function print_eps_and_png( filehint )
%
%
%

d_prt = '-depsc2'; fmt = 'eps'; 
file_out = sprintf('%s.%s',filehint,fmt); 
print( d_prt, file_out ); 
d_prt = '-dpng'; fmt = 'png'; 
file_out = sprintf('%s.%s',filehint,fmt); 
print( d_prt, file_out ); 
fprintf('%s written.\n',file_out); 

