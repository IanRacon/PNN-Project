function [ propability ] = yg( samples, x, sigma, attributesQuantity )
%returns propability that sample "x" belong to class given in "samples"
%"samples" means data only from one class
samplesCount = size(samples, 2);
attributesCount = attributesQuantity;

lg = samplesCount;
n = attributesCount;
sumInlgSpan = 0;
for i=1:lg
    sumInNSpan = 0;
    for j = 1:n
       sumInNSpan = sumInNSpan + (samples(j, i) - x(j))^2/(2*sigma^2);
    end
    sumInlgSpan = sumInlgSpan + exp(-sumInNSpan);
end
propability = 1/(lg*(2*pi)^(n/2))*sumInlgSpan;
end

