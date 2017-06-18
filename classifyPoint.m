function [ classIndex, maxValue, penalty ] = classifyPoint( setsOfPoints, newPoint, sigma )
%setsOfPoints is a matrix where third dimension defines class

global logsEnabled;

attributesQuantity = 2;
numOfClasses = size(setsOfPoints, 3);


propabilities = [];

for i = 1:numOfClasses
    classPoints = setsOfPoints(:, :, i); %move i-th class to "classPoints"
    pointPropability = yg( classPoints, newPoint, sigma, attributesQuantity);
    
%     fprintf('New point at x:%f, y:%f have to class with index:%d, propability:%f \n', ...
%         newPoint(1), newPoint(2), i, pointPropability);

    propabilities = [propabilities, pointPropability];
end

[maxValue, classIndex] = max(propabilities);
penalty = sum(propabilities) - maxValue;

if(logsEnabled)
    fprintf('New point at x:%f, y:%f should go to class with index:%d with propability:%f \n', ...
    newPoint(1), newPoint(2), classIndex, maxValue);
end

end

