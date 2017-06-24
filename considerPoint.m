function [ setsOfPoints, mismatch ] = considerPoint( setsOfPoints, newPoint, p_time, p_propability, p_penalty )
%setsOfPoints is a matrix where third dimension defines class

globals;
mismatch = 0;

sigma = 1;
for i = 1:size(setsOfPoints, 3)
   setsOfPoints(:, :, i) = increaseTime(setsOfPoints(:, :, i));
end

[classIndex, propability, penalty] = classifyPoint(setsOfPoints, newPoint, sigma);

targetClass = newPoint(classOfPointIndex);
% fprintf('Target class: %d, predicted class: %d\n', ...
%     targetClass, classIndex);
% pause(0.5);
if(classIndex ~= targetClass)
    newPoint(penaltyIndex) = 1000000;
    newPoint(propabilityIndex) = 0;
    mismatch = 1;
else
    newPoint(propabilityIndex) = propability;
    newPoint(penaltyIndex) = penalty;
    mismatch = 0;
end

chosenClass = setsOfPoints(:, :, targetClass);
% chosenClass = setsOfPoints(:, :, classIndex);

extendedPoints = evaluateNewPoint( chosenClass, newPoint, sigma, p_time, p_propability, p_penalty);

setsOfPoints(:, :, targetClass) = extendedPoints;
end

