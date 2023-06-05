function print_bmp( filehint )
%
%
%

d_prt = '-dbmp'; fmt = 'bmp'; 
file_out = sprintf('%s.%s',filehint,fmt); 
print( d_prt, file_out ); 
fprintf('%s written.\n',file_out); 
