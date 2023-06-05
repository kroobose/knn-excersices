function ret = subscellref(a,r)
%
% ret = subscellref(a,r)
%

if ( islogical(r) )
  if (length(a)~=length(r)) err(1:3)=1:2; end;
  r = find(r);
end

nrows = size(a,1);
ncols = size(a,2);
if (~(nrows==1 | ncols==1)), err(1:3)=1:2; end;
if ( nrows==1 )
  ret = cell(1,length(r));
else 
  ret = cell(length(r),1);
end
for i=1:length(r)
  ret{i} = a{r(i)};
end



