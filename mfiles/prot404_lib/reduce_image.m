function img_ret = reduce_image( img_gray )
%
%
%

hei_in = size( img_gray, 1 ); 
wid_in = size( img_gray, 2 ); 
hei_out = floor(hei_in*0.5); 
wid_out = floor(wid_in*0.5); 
img_ret = zeros(hei_out,wid_out); 
for j_out=1:hei_out
  for i_out=1:wid_out
    r_y = (j_out-1)*2 + (1:2); 
    r_x = (i_out-1)*2 + (1:2); 
    tmp1 = img_gray(r_y,r_x); 
    img_ret(j_out,i_out) = mean(tmp1(:)); 
  end
end
