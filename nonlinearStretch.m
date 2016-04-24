function result = nonlinearStretch(I,rgb,alfa,beta)

s = size(I);
result=I;

min = 0;
max = 1;

y = @(x) (max - min)*(1/(1+exp(-(x-beta)/alfa))) + min;

for i = 1:s(1)
    for j = 1:s(2)
        result(i,j,rgb) = y(I(i,j,rgb));
    end
end


end