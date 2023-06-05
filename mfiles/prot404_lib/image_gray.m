function img1 = image_gray( x, hei, wid )
%
%
%

x        = double(x); 
x        = min(max(x,0),1); 
img_gray = reshape( x, hei, wid ); 
img_rgb  = zeros( hei, wid, 3 ); 
img_rgb(:,:,1) = img_gray; 
img_rgb(:,:,2) = img_gray; 
img_rgb(:,:,3) = img_gray; 
img1 = image( img_rgb ); 

