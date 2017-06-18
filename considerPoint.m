function [ setsOfPoints ] = considerPoint( setsOfPoints, newPoint )
%setsOfPoints is a matrix where third dimension defines class
sigma = 1;
for i = 1:size(setsOfPoints, 3)
   setsOfPoints(:, :, i) = increaseTime(setsOfPoints(:, :, i));
end

[classIndex, maxValue, penalty] = classifyPoint(setsOfPoints, newPoint, sigma);
newPoint(4) = maxValue;
newPoint(5) = penalty;
chosenClass = setsOfPoints(:, :, classIndex);
extendedPoints = evaluateNewPoint( chosenClass, newPoint, sigma);
setsOfPoints(:, :, classIndex) = extendedPoints;
end

