function [ points ] = evaluate( points, newPoint, sigma)
%points should be a matrix of the form:
%[pointsParams, pointsQuantity]
%where one point (one column) is a vector
%[position x, position y, lifeTime, propability, score]

fprintf('New point at x:%f, y:%f', newPoint(1), newPoint(2));

points = [points , newPoint];
pointsQuantity = size(points, 2);
attributesQuantity = 2;

for i=1:pointsQuantity
    points(3, i) = points(3, i) + 1; %increase lifeTime
    points(4, i) = yg( points, points(:, i), sigma, attributesQuantity );
    points(5, i) = comptScore(points(3, i), points(4, i));
end
[score, index] = min(points(5, :));
fprintf('Erasing worst point at index %d, with score value:%d, lifeTime:%d, propabilityValue:%f x:%f, y:%f', ...
index, score, points(3, index), points(4, index), points(1, index), points(2, index));

points(:, index) = [];

end

