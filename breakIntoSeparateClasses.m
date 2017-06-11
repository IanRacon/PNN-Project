function [ classCount , separateClasses, separateClassesTargets ] = breakIntoSeparateClasses( samples, samplesTargets, oneClassSize)
samplesCount = size(samples, 2);
uniqueValues = unique(samplesTargets);
classCount = size(uniqueValues, 2);
attribSize = size(samples, 1);
classSize = size(samplesTargets, 1);

separateClasses = zeros(attribSize, samplesCount);
separateClassesTargets = zeros(classSize, samplesCount);

counter = 1;
for j = 1:classCount
    for i = 1:samplesCount
       if(samplesTargets(i) == uniqueValues(j))
            separateClasses(:, counter) = samples(:, i);
            separateClassesTargets(:, counter) = samplesTargets(:, i);
            counter = counter + 1;
       end
    end
end
end

