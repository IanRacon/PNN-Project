function [ setsOfPoints ] = considerPoint( setsOfPoints, newPoint )
%setsOfPoints is a matrix where third dimension defines class
sigma = 1;
classIndex = classifyPoint(setsOfPoints, newPoint, sigma);
chosenPoints = setsOfPoints(:, :, classIndex);
extendedPoints = evaluate( chosenPoints, newPoint, sigma);
setsOfPoints(:, :, classIndex) = extendedPoints;
end

