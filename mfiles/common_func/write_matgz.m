function write_matgz( file_out, Xs )
%
% f( file_out, Xs )
%
file_ungz = strrep( file_out, '.matgz', '.matungz' ); 
file_gz = strrep( file_out, '.matgz', '.matungz.gz' ); 

tsassert( numel( strfind( file_out, '.matgz' ) ) > 0 ); 

fid = fopen( file_ungz, 'w', 'ieee-be' ); 
nmats = numel(Xs); 
fwrite( fid, '#',   'uchar' ); 
fwrite( fid, nmats, 'int32' ); 
for i_mat=1:nmats
  X = Xs{i_mat}; 
  nrows = size(X,1); 
  ncols = size(X,2); 
  tmp1  = X'; tmp1 = tmp1(:); 
  fwrite( fid, '#',   'uchar' ); 
  fwrite( fid, nrows, 'int32' ); 
  fwrite( fid, '#',   'uchar' ); 
  fwrite( fid, ncols, 'int32' ); 
  fwrite( fid, tmp1,  'double' ); 
end
fclose(fid); 

if is_matlab()
  gzip( file_ungz ); 
else
  signal1 = system( sprintf('gzip %s',file_ungz) ); 
  tsassert( signal1 == 0 ); 
end
movefile( file_gz, file_out ); 
fprintf('%s written.\n',file_out); 





