function [ points ] = evaluateNewPoint( points, newPoint, sigma)
%points should be a matrix of the form:
%[pointsParams, pointsQuantity]
%where one point (one column) is a vector
%[position x, position y, lifeTime, propability, penalty, score]
global lifeTimeIndex;
global logsEnabled;

points = [points , newPoint];
pointsQuantity = size(points, 2);
attributesUsedToClassification = 2;

for i=1:pointsQuantity
%     points(3, i) = points(3, i) + 1; %increase lifeTime
    points(6, i) = yg( points, points(:, i), sigma, attributesUsedToClassification );
    points(8, i) = comptScore(points(lifeTimeIndex, i), points(6, i), points(7, i));
end
[score, index] = min(points(8, :));

if(logsEnabled)
    fprintf('Erasing worst point at index %d, with score value:%f, lifeTime:%d, propabilityValue:%f, penaltyVlaue:%f', ...
    index, score, points(lifeTimeIndex, index), points(6, index), points(7, index));
end

points(:, index) = [];

end

