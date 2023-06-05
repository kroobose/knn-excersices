function roc2 = calcrocscore(score,y_orac)

[fp,tp]=calcroc(score,y_orac); 

s2 = zeros(length(tp)-1,1);
for i=1:length(s2)
  s2(i) = (fp(i+1)-fp(i))*(tp(i)+tp(i+1))*0.5;
end
roc2 = sum(s2); 
