function [ errors ] = getErrorPoints( setsOfAcutalHoldedPoints, realPoints )
classesCount = size(setsOfAcutalHoldedPoints, 3);
classSamplesCount = size(setsOfAcutalHoldedPoints, 2);
samplesCount = size(realPoints, 2);
if(samplesCount~=classSamplesCount)
    fprintf('classSamplesCount and samplesCount must agree! \n');
end
global serialNumberIndex;
global classOfPointIndex;
global pointAttribsCount;

errors = zeros(pointAttribsCount, 0);

for classIndex = 1:classesCount
    for sampleIndex= 1:classSamplesCount
        pointSerial = setsOfAcutalHoldedPoints(serialNumberIndex, sampleIndex, classIndex);
        pointClass = setsOfAcutalHoldedPoints(classOfPointIndex, sampleIndex, classIndex);
        foundedIndex = find(realPoints(serialNumberIndex, :) == pointSerial);
        if(realPoints(classOfPointIndex, foundedIndex) ~= pointClass)
            errors = [errors, realPoints(:, foundedIndex)];
        end
    end
end
end

