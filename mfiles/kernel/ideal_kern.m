function ret = ideal_kern(cts)

N = length(cts);
ret = zeros(N,N);
for i=1:N
  for j=1:N
    if cts(i) == cts(j)
      ret(i,j) = 1;
    end
  end
end
  