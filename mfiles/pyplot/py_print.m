function canv1 = py_print( canv1, filehint )
%
%
%
file_out = sprintf('%s.png',filehint); 
ln_out = sprintf('file_out=''%s'';',file_out); 
canv1.lns{end+1} = ln_out; 
ln_out = sprintf('plt.savefig(file_out);'); 
canv1.lns{end+1} = ln_out; 
ln_out = sprintf('print file_out,''written.'';'); 
canv1.lns{end+1} = ln_out; 

file_matgz = sprintf('%s.Xs.matgz',filehint); 
write_matgz( file_matgz, canv1.Xs ); 

lns_out = cell(0,0); 
lns_out{end+1} = '#!/usr/bin/python'; 
lns_out{end+1} = 'import numpy as np'; 
lns_out{end+1} = 'import matplotlib.pyplot as plt'; 
lns_out{end+1} = 'import gzip'; 
lns_out{end+1} = 'import struct'; 
lns_out{end+1} = 'import sys;';
lns_out{end+1} = 'sys.path.append(''../lib'');'; 
% lns_out{end+1} = 'import tsutil;';

lns_out{end+1} = 'def read_matgz(file_in):';
lns_out{end+1} = '    fp = gzip.open(file_in,''rb'');';
lns_out{end+1} = '    data = fp.read(); fp.close(); ';
lns_out{end+1} = '    nmats_packed = data[1:5]; data = data[5:]; ';
lns_out{end+1} = '    nmats = struct.unpack(''>i'',nmats_packed)[0]; ';
lns_out{end+1} = '    Xs = []; ';
lns_out{end+1} = '    for i_mat in range(nmats):';
lns_out{end+1} = '        nrows_packed = data[1:5]; ';
lns_out{end+1} = '        ncols_packed = data[6:10]; data = data[10:];';
lns_out{end+1} = '        nrows = struct.unpack(''>i'',nrows_packed)[0];'; 
lns_out{end+1} = '        ncols = struct.unpack(''>i'',ncols_packed)[0]; ';
lns_out{end+1} = '        assert nrows < 1000; ';
lns_out{end+1} = '        assert ncols < 1000; ';
lns_out{end+1} = '        ary = []; ';
lns_out{end+1} = '        for i in range(nrows*ncols):';
lns_out{end+1} = '            tmp1 = data[:8]; data = data[8:]; ';
lns_out{end+1} = '            tmp2 = struct.unpack(''>d'',tmp1)[0]; ';
lns_out{end+1} = '            ary.append(tmp2); ';
lns_out{end+1} = '        ary = np.array( ary ); ';
lns_out{end+1} = '        ary = ary.reshape(nrows,ncols); ';
lns_out{end+1} = '        Xs.append(ary); ';
lns_out{end+1} = '    return Xs; ';
lns_out{end+1} = sprintf('file_in = ''%s'';',file_matgz); 
lns_out{end+1} = 'if len(sys.argv) >= 2:';
lns_out{end+1} = '    file_in = sys.argv[1]; ';
lns_out{end+1} = 'Xs_plt = read_matgz(file_in);'; 
lns_out = cat( 2, lns_out, canv1.lns ); 

file_out = sprintf('%s.pyplot.py',filehint); 
write_lns( file_out, lns_out ); 


