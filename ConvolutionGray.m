function result = ConvolutionGray(img, matrix)

s = size(img);
result = img;
acc = 0.0;

for i = 2:(s(1)-1)
    for j = 2:(s(2)-1)
        acc = acc * 0;

        for k = 1:3
            for l = 1:3
 
                tmp = img(i-(k-2),j-(l-2));
                acc = acc + tmp * matrix(k,l);

            end
        end
        
        acc = round(acc);
        result(i,j) = acc;
    end
end
return
end

