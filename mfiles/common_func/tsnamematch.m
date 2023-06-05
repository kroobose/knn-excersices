function [r1,r2] = tsnamematch(name1,name2)

if ~iscellstr(name1)
  tmp = name1; name1 = cell(1,1); name1{1} = tmp;
end
if ~iscellstr(name2)
  tmp = name2; name2 = cell(1,1); name2{1} = tmp;
end

rownum = length(name1); orfnum = length(name2);

r1 = [];
r2 = [];

for i=1:rownum
  for j=1:orfnum
    if (strcmp(name1{i},name2{j}))
      r1 = [r1 i];
      r2 = [r2 j];
    end
  end
end

