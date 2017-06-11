function [ err ] = acc( samples, samplesTargets, sigma, oneClassSize)

[ classCount , separateClasses, separateClassesTargets ] = breakIntoSeparateClasses(samples, samplesTargets, oneClassSize);

attribSize = size(samples, 1);
samplesCount = size(samples, 2);
classes = zeros(classCount, attribSize, oneClassSize);

targetsByClassesCount = zeros(1, classCount);

correct = 0;
for i=1:classCount
    startInd = 1+(i-1)*oneClassSize;
    endInd = i*oneClassSize;
    classValues = separateClasses(:, startInd:endInd);
    classes(i, :, :) = classValues;
    targetsByClassesCount(i) = separateClassesTargets(:, startInd);
end


for i = 1:samplesCount
    classesPropability = zeros(1, classCount);
    for j=1:classCount
        predictedPropability = yg(classes(j, :, :), samples(:, i), sigma);
        classesPropability(j) = predictedPropability;
    end
    [maxVal, maxValInd] = max(classesPropability);
    
    if(targetsByClassesCount(maxValInd) == samplesTargets(i))
        correct = correct + 1;
    end
end
err = correct/samplesCount;
end

