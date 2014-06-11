tarmat=zeros(66,44*66);
for i=1:66
    for j=1:44
        tarmat(i,44*(i-1)+j)=1;
    end
end
