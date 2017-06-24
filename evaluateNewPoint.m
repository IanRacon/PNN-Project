function [ points ] = evaluateNewPoint( points, newPoint, sigma, p_time, p_propability, p_penalty)
%points should be a matrix of the form:
%[pointsParams, pointsQuantity]
%where one point (one column) is a vector
%[position x, position y, lifeTime, propability, penalty, score]
globals;

points = [points , newPoint];
pointsQuantity = size(points, 2);
attributesUsedToClassification = 2;
    
for i=1:pointsQuantity
%     points(3, i) = points(3, i) + 1; %increase lifeTime
    points(propabilityIndex, i) = yg( points, points(:, i), sigma, attributesUsedToClassification );
    points(8, i) = comptScore(points(lifeTimeIndex, i), points(6, i), points(7, i), p_time, p_propability, p_penalty);
end
[score, index] = min(points(8, :));

if(logsEnabled)
    fprintf('Erasing worst point at serial %d, class: %d with score value:%f, lifeTime:%d, propabilityValue:%f, penaltyVlaue:%f \n', ...
    points(serialNumberIndex, index), points(classOfPointIndex, index), score, points(lifeTimeIndex, index), points(6, index), points(7, index));
end

points(:, index) = [];

end

