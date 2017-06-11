function [ box ] = getBoxSize( SSE, samplesCount )
for i = 1:samplesCount
    if ((SSE >= (i - 1) /samplesCount) && (SSE < i / samplesCount))
        box = i - 1;
        break;
    end
end
end

