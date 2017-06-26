clear all;
stepSize = 300;
startTime = stepSize*2;
windowSize = 75;
maxTime = stepSize*2*17;
spread = 1;

globals;

pointAttribsCount = 8;
penaltyIndex = 7;
propabilityIndex = 6;
lifeTimeIndex = 5;
classOfPointIndex = 4;
serialNumberIndex = 3;
serialNumber = 1;
logsEnabled = false;

step = 50;

% point parameters are following [position x, position y, serialNumber, class, lifeTime, propability, penalty, score]
realPoints = zeros(pointAttribsCount, maxTime); 

numOfClasses = 2;

errorPoints = zeros(2, 0);

class1Points = zeros(pointAttribsCount, windowSize);
class2Points = zeros(pointAttribsCount, windowSize);
class3Points = zeros(pointAttribsCount, windowSize);

for i = 1:maxTime;
    if mod(i,3) == 0;
        realPoints(:,i) = generateClasss2PointSet2(i/2, stepSize)';
        realPoints(classOfPointIndex,i) = 2;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
    elseif mod(i, 3) == 1;
        realPoints(:,i) = generateRandomPoint(-2,0);
        realPoints(classOfPointIndex,i) = 1;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
    else
        realPoints(:,i) = generateRandomPoint(2,0);
        realPoints(classOfPointIndex,i) = 3;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
    end
end


itClass1 = 1;
itClass2 = 1;
itClass3 = 1;
for i = 1:numOfClasses*windowSize;
    if mod(i,3) == 0;
        class2Points(:, itClass2) = realPoints(:, i);
        itClass2 = itClass2 + 1;
    elseif mod(i, 3) == 1;
        class1Points(:, itClass1) = realPoints(:, i);
        itClass1 = itClass1 + 1;
    elseif mod(i, 3) == 2;
        class3Points(:, itClass3) = realPoints(:, i);
        itClass3 = itClass3 + 1;
    end
end

setsOfPoints = zeros(pointAttribsCount, windowSize, numOfClasses);

totalPoints = 0;
% figure('visible','on');
it = 1;
errorArray = zeros(2, 0);
setsOfPoints(:, :, 1) = class1Points;
setsOfPoints(:, :, 2) = class2Points;
setsOfPoints(:, :, 3) = class3Points;
for k = startTime:step:maxTime-1
    errors = 0;
        for j = 1:step
            i = k + j -1;
            [setsOfPoints, mismatch] = considerPoint(setsOfPoints, realPoints(:, i), 2000, 1, 0.1);
            if mismatch == 1
                errors = errors + 1;
            end
            subplot(2,1,1);
            lim = 10;
            if(i+windowSize > maxTime)
                visibilityRange = maxTime;
            else
                visibilityRange = i+windowSize;
            end
            
            plot(realPoints(1, i:visibilityRange), realPoints(2, i:visibilityRange), 'g*', ...
                 errorPoints(1,:), errorPoints(2,:), 'r*', ...
                 setsOfPoints(1, :, 1), setsOfPoints(2, :, 1), 'm+', ... 
                 setsOfPoints(1, :, 2), setsOfPoints(2, :, 2), 'ko', ...
                setsOfPoints(1, :, 3), setsOfPoints(2, :, 3), 'mo');

            xlim([-lim,lim]);
            ylim([-lim,lim]);


            subplot(2,1,2);
            plot(errorArray(1, :), errorArray(2, :));
            xlabel('ilosc dodanych punktow')
            ylabel('procent blednych punktow');
            drawnow;
        end
        totalPoints = totalPoints + step;
        errorArray = [errorArray, [totalPoints; errors/step*100]];
end
mean(errorArray(2,:))

% subplot(2,1,1);
% lim = 10;
% % plot(realPoints(1, i:visibilityRange), realPoints(2, i:visibilityRange), 'g*', ...
%     plot(errorPoints(1,:), errorPoints(2,:), 'r*', ...
%      setsOfPoints(1, :, 1), setsOfPoints(2, :, 1), 'm+', ... 
%      setsOfPoints(1, :, 2), setsOfPoints(2, :, 2), 'ko', ...
%     setsOfPoints(1, :, 3), setsOfPoints(2, :, 3), 'mo');
% 
% xlim([-lim,lim]);
% ylim([-lim,lim]);
%             
% subplot(2,1,2);
% plot(errorArray(1, :), errorArray(2, :));
% xlabel('ilosc dodanych punktow');
% ylabel('procent blednych punktow');

