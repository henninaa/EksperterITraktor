function result = ConvolutionRGB(img, matrix)

s = size(img);
result = img;
acc = [0.0;
    0.0;
    0.0];

sp = size(matrix);

kpf = floor(sp(1)/2);
kpc = ceil(sp(1)/2);

lpf = floor(sp(2)/2);
lpc = ceil(sp(2)/2);

for i = kpc:(s(1)-kpf)
    for j = lpc:(s(2)-lpf)
        acc = acc * 0;

        for k = 1:sp(1)
            for l = 1:sp(2)
 
                tmpVec = makeVector(img(i-(k-kpc),j-(l-lpc),:))';
                acc = acc + tmpVec * matrix(k,l);

            end
        end

        result(i,j,:) = acc;
    end
end
return
end