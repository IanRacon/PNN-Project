clear all;
stepSize = 500;
startTime = stepSize*2;
windowSize = 75;
maxTime = stepSize*2*9;
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

% points = zeros(2, maxTime);

% zeros(point paramters, samplesCount, classesCount)
% point parameters are following [position x, position y, serialNumber, class, lifeTime, propability, penalty, score]
realPoints = zeros(pointAttribsCount, maxTime); 

numOfClasses = 2;

errorPoints = zeros(2, 0);

class1Points = zeros(pointAttribsCount, windowSize);
class2Points = zeros(pointAttribsCount, windowSize);

for i = 1:maxTime;
    if mod(i,2) == 0;
        realPoints(:,i) = generateClasss2PointSet(i/2, stepSize)';
        realPoints(classOfPointIndex,i) = 2;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
    elseif mod(i, 2) == 1;
        realPoints(:,i) = generateRandomPoint(0,0);
        realPoints(classOfPointIndex,i) = 1;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
    end
end


itClass1 = 1;
itClass2 = 1;

for i = 1:numOfClasses*windowSize;
    if mod(i,2) == 0;
        class2Points(:, itClass2) = realPoints(:, i);
        itClass2 = itClass2 + 1;
    elseif mod(i, 2) == 1;
        class1Points(:, itClass1) = realPoints(:, i);
        itClass1 = itClass1 + 1;
    end
end

setsOfPoints = zeros(pointAttribsCount, windowSize, numOfClasses);

% figure('visible','on');
it = 1;
errorArray = zeros(2, 0);
setsOfPoints(:, :, 1) = class1Points;
setsOfPoints(:, :, 2) = class2Points;
totalPoints = 0;
for k = startTime:step:maxTime-1
    errors = 0;
        for j = 1:step
            i = k + j -1;
            p_propability = 0.5;
            [setsOfPoints, mismatch] = considerPoint(setsOfPoints, realPoints(:, i), 500, 0.5, 1);
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
                 setsOfPoints(1, :, 2), setsOfPoints(2, :, 2), 'ko');

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
%      setsOfPoints(1, :, 2), setsOfPoints(2, :, 2), 'ko');
% 
% xlim([-lim,lim]);
% ylim([-lim,lim]);
%             
% subplot(2,1,2);
% plot(errorArray(1, :), errorArray(2, :));
% xlabel('ilosc dodanych punktow');
% ylabel('procent blednych punktow');