%
% lns = read_lns( file )
%
function lns = read_lns( file )

fid = fopen(file,'r');

lns = cell(0,0); 
i = 1;
while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    lns{i} = tline;
    i = i + 1;
end
fclose(fid);
if length( lns{end} )  == 0, 
  fprintf('%g\n',length(lns)); 
  lns = subscellref( lns, 1:(length(lns)-1) ); 
  fprintf('%g\n',length(lns)); 
end

