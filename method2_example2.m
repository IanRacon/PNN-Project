stepSize = 200;
startTime = stepSize*2;
windowSize = 50;
% maxTime = stepSize*2*8;
maxTime = stepSize*2*17;
spread = 0.0001;

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
class3Points = zeros(pointAttribsCount, windowSize);

% for i = 1:maxTime;
%     if mod(i,2) == 0;
%         realPoints(:,i) = generateClasss2PointSet(i/2, stepSize)';
%         realPoints(classOfPointIndex,i) = 2;
%         realPoints(serialNumberIndex,i) = serialNumber;
%         serialNumber = serialNumber + 1;
%     else
%         realPoints(:,i) = generateClasss1PointSet((i+1)/2, stepSize)';
%         realPoints(classOfPointIndex,i) = 1;
%         realPoints(serialNumberIndex,i) = serialNumber;
%         serialNumber = serialNumber + 1;
%     end
% end
% 
% itClass1 = 1;
% itClass2 = 1;
% for i = 1:windowSize;
%     if mod(i,2) == 0;
%         class2Points(:, itClass2) = realPoints(:, i);
%         itClass2 = itClass2 + 1;
%     elseif mod(i, 2) == 1;
%         class1Points(:, itClass1) = realPoints(:, i);
%         itClass1 = itClass1 + 1;
%     end
% end

for i = 1:maxTime;
    if mod(i,3) == 0;
        realPoints(:,i) = generateClasss2PointSet2(i/2, stepSize)';
        realPoints(classOfPointIndex,i) = 2;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
%         targets(i) = 1;
%         results(i) = 1;
    elseif mod(i, 3) == 1;
        realPoints(:,i) = generateRandomPoint(-2,0);
%         realPoints(:,i) = generateClasss1PointSet2((i+1)/2, stepSize)';
        realPoints(classOfPointIndex,i) = 1;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
    else
        realPoints(:,i) = generateRandomPoint(2,0);
%         realPoints(:,i) = generateClasss1PointSet2((i+1)/2, stepSize)';
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

setsOfPoints(:, :, 1) = class1Points;
setsOfPoints(:, :, 2) = class2Points;
setsOfPoints(:, :, 3) = class3Points;
%generowanie obrazków demonstrujących dane wejściowe 

% for endTime = 200:200:maxTime;
%     fig = figure('visible','off');
%     plot(points(1,1:2:endTime), points(2,1:2:endTime), 'r*', points(1,2:2:endTime), points(2,2:2:endTime), 'g*');
%     lim = 6;
%     xlim([-lim,lim]);
%     ylim([-lim,lim]);
%     fileName = sprintf('dataGen_step%i', (endTime-200)/200);
%     saveas(fig, fileName, 'png');
% end
meanArray = [];
p_timeArray = [];
p_penaltyArray = [];
p_propabilityArray = [];

% figure('visible','on');
it = 1;
errorArray = [];
setsOfPoints(:, :, 1) = class1Points;
setsOfPoints(:, :, 2) = class2Points;
setsOfPoints(:, :, 3) = class3Points;
for k = startTime:step:maxTime
    errors = 0;
        for j = 1:step
            i = k + j -1;
            p_propability = 0.5;
            [setsOfPoints, mismatch] = considerPoint(setsOfPoints, realPoints(:, i), 500, 0.5, 1);
            if mismatch == 1
                errors = errors + 1;
            end
%                     errors = getErrorPoints(setsOfPoints);           
%                         errorArray = [errorArray, [i;errors/(size(setsOfPoints, 2)*numOfClasses)*100]];

            subplot(3,1,1);
            lim = 5;
            if(i+windowSize > maxTime)
                visibilityRange = maxTime;
            else
                visibilityRange = i+windowSize;
            end

            plot(realPoints(1, i:visibilityRange), realPoints(2, i:visibilityRange), 'g*', ...
                 errorPoints(1,:), errorPoints(2,:), 'r*', ...
                 setsOfPoints(1, :, 1), setsOfPoints(2, :, 1), 'm+', ... 
                 setsOfPoints(1, :, 2), setsOfPoints(2, :, 2), 'yo', ...
                setsOfPoints(1, :, 3), setsOfPoints(2, :, 3), 'mo');

            xlim([-lim,lim]);
            ylim([-lim,lim]);

            subplot(2,1,2);
            plot(errorArray);
            xlabel('ilosc dodanych punktow')
            ylabel('procent blednych punktow');
        %     
        %     subplot(3,1,3);
        %     plot(spreadArray(1,:), spreadArray(2,:));
        %     xlabel('ilosc dodanych punktow')
        %     ylabel('wartosc spread');
        %     
        %     
            drawnow;

        end
        errorArray = [errorArray, errors/step];
%     it = it +1
%     mean(errorArray(2,:))
%     p_time
%     p_penalty
%     p_propability
%     meanArray = [meanArray, mean(errorArray(2,:))];
%     p_timeArray = [p_timeArray, p_time];
%     p_penaltyArray = [p_penaltyArray, p_penalty];
%     p_propabilityArray = [p_propabilityArray, p_propability];
end
% fig = figure;
% plot(1:size(meanArray, 2), meanArray);
% ylabel('Średni błąd');
% xlabel('');
% print(fig, strcat('mean'), '-dpng');
% 
% plot(1:size(p_timeArray, 2), p_timeArray);
% ylabel('Parametr czasu');
% xlabel('');
% print(fig, strcat('time'), '-dpng');
% 
% plot(1:size(p_penaltyArray, 2), p_penaltyArray);
% ylabel('Parametr kary');
% xlabel('');
% print(fig, strcat('penalty'), '-dpng');
% 
% plot(1:size(p_propabilityArray, 2), p_propabilityArray);
% ylabel('Parametr prawdopodobieństwa');
% xlabel('');
% print(fig, strcat('propability'), '-dpng');



