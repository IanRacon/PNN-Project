function [ setsOfPoints ] = considerPoint( setsOfPoints, newPoint )
%setsOfPoints is a matrix where third dimension defines class

globals;

sigma = 1;
for i = 1:size(setsOfPoints, 3)
   setsOfPoints(:, :, i) = increaseTime(setsOfPoints(:, :, i));
end

[classIndex, propability, penalty] = classifyPoint(setsOfPoints, newPoint, sigma);
newPoint(propabilityIndex) = propability;
newPoint(penaltyIndex) = penalty;
chosenClass = setsOfPoints(:, :, classIndex);
extendedPoints = evaluateNewPoint( chosenClass, newPoint, sigma);
setsOfPoints(:, :, classIndex) = extendedPoints;
end

