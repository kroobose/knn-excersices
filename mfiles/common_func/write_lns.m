%
% write_lns( file_out, lns );
%
function write_lns( file_out, lns );

if strcmp( file_out, 'stdout' )
  fid = 1;
else
  fid = fopen(file_out,'w');
end
for i=1:length(lns)
  fprintf(fid,'%s\n',lns{i});
end
if fid ~= 1,
  fclose(fid);
  fprintf('%s written.\n',file_out);
end

