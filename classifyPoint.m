function [ classIndex, propability, penalty ] = classifyPoint( setsOfPoints, newPoint, sigma )
%setsOfPoints is a matrix where third dimension defines class

globals;

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

[propability, classIndex] = max(propabilities);
penalty = sum(propabilities) - propability;

if(newPoint(classOfPointIndex) ~= classIndex)
    fprintf('Bad classification \n');
end

if(logsEnabled)
    fprintf('New point at x:%f, y:%f, class:%f had propabilities to classes: 1: %f, 2: %f should go to class with index:%d with propability:%f and penalty %f \n', ...
    newPoint(1), newPoint(2),newPoint(classOfPointIndex) ,propabilities(1),propabilities(2), classIndex, propability, penalty);
end

end

