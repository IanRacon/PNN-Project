function [ errors ] = getErrorPoints( setsOfAcutalHoldedPoints )
classesCount = size(setsOfAcutalHoldedPoints, 3);
classSamplesCount = size(setsOfAcutalHoldedPoints, 2);
% samplesCount = size(realPoints, 2);
% if(samplesCount~=classSamplesCount)
%     fprintf('classSamplesCount and samplesCount must agree! \n');
% end
globals;

% errors = zeros(pointAttribsCount, 0);
errors = 0;
for classIndex = 1:classesCount
    for sampleIndex= 1:classSamplesCount
        pointClass = setsOfAcutalHoldedPoints(classOfPointIndex, sampleIndex, classIndex);
        if(pointClass ~= classIndex)
           errors = errors+1; 
        end
        
%         pointSerial = setsOfAcutalHoldedPoints(serialNumberIndex, sampleIndex, classIndex);
%         pointClass = setsOfAcutalHoldedPoints(classOfPointIndex, sampleIndex, classIndex);
%         foundedIndex = find(realPoints(serialNumberIndex, :) == pointSerial);
        
        
        
%         if(logsEnabled)
%             fprintf('Class point serial: %d, class: %d match real point at serial number: %d, with class: %d \n', ...
%             pointSerial, pointClass, realPoints(serialNumberIndex, foundedIndex), realPoints(classOfPointIndex, foundedIndex));
%         end
%         if(realPoints(classOfPointIndex, foundedIndex) ~= pointClass)
%             fprintf('Class point serial: %d, class: %d not match real point at serial number: %d, with class: %d \n', ...
%             pointSerial, pointClass, realPoints(serialNumberIndex, foundedIndex), realPoints(classOfPointIndex, foundedIndex));
%         
% %             errors = [errors, realPoints(:, foundedIndex)];
%         end
    end
end
end

