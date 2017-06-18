function [  ] = method2()

stepSize = 200;
startTime = stepSize*2;
windowSize = 200;
maxTime = stepSize*2*8;
spread = 0.0001;

globals;

pointAttribsCount = 8;
penaltyIndex = 7;
propabilityIndex = 6;
lifeTimeIndex = 5;
classOfPointIndex = 4;
serialNumberIndex = 3;
serialNumber = 1;
logsEnabled = true;

step = 1;

% points = zeros(2, maxTime);

% zeros(point paramters, samplesCount, classesCount)
% point parameters are following [position x, position y, serialNumber, class, lifeTime, propability, penalty, score]
realPoints = zeros(pointAttribsCount, maxTime); 

targets = zeros(1, maxTime);
results = zeros(1, maxTime);
errorArray = zeros(2, 0);
spreadArray = zeros(2, 0);

errorPoints = zeros(2, 0);

class1Points = zeros(pointAttribsCount, windowSize/2);
class2Points = zeros(pointAttribsCount, windowSize/2);

for i = 1:maxTime;
    if mod(i,2) == 0;
        realPoints(:,i) = generateClasss2PointSet(i/2, stepSize)';
        realPoints(classOfPointIndex,i) = 2;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
        targets(i) = 1;
        results(i) = 1;
    else
        realPoints(:,i) = generateClasss1PointSet((i+1)/2, stepSize)';
        realPoints(classOfPointIndex,i) = 1;
        realPoints(serialNumberIndex,i) = serialNumber;
        serialNumber = serialNumber + 1;
        targets(i) = 2;
        results(i) = 2;
    end
end
itClass1 = 1;
itClass2 = 1;
for i = 1:windowSize;
    if mod(i,2) == 0;
        class2Points(:, itClass2) = realPoints(:, i);
        itClass2 = itClass2 + 1;
    else
        class1Points(:, itClass1) = realPoints(:, i);
        itClass1 = itClass1 + 1;
    end
end

setsOfPoints = zeros(pointAttribsCount, windowSize/2, 2);

setsOfPoints(:, :, 1) = class1Points;
setsOfPoints(:, :, 2) = class2Points;
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

figure('visible','on');
% T = ind2vec(targets(1:startTime));
% net = newpnn(points(:,1:startTime), T, spread);

for i = startTime:step:maxTime
    setsOfPoints = considerPoint(setsOfPoints, realPoints(:, i));
    
%     errorPoints = getErrorPoints(setsOfPoints, realPoints);
    errors = getErrorPoints(setsOfPoints, realPoints);
    
%     results = net(realPoints(:,i:startTime+i));
    
%     results = vec2ind(net(points(:,i:startTime+i)));
%     errorVector = abs(results(1:startTime+1) - targets(i:startTime+i));
%     errorArray = [errorArray, [i; sum(errorVector)*100/step]];
    errorArray = [errorArray, [i;errors/(size(setsOfPoints, 2)*2)*100]];
%     
%     errorPoints = zeros(2, 0);
%     for j = i:startTime+i
%         if results(j-i+1) ~= targets(j)
%             errorPoints = [errorPoints, realPoints(:,j)];
%         end
%     end
    
%     spread = calculateSpread(points(i:startTime-step+i),targets(i:startTime-step+i),(startTime-step)/2, points(startTime-step+i+1:startTime+i),targets(startTime-step+1+i:startTime+i),(step)/2);
%     spreadArray = [spreadArray, [i; spread]];
    
%     T = ind2vec(targets(i:startTime+i));
%     net = newpnn(realPoints(:,i:startTime+i), T, spread);

    
    subplot(3,1,1);
    lim = 10;
    if(i+windowSize > maxTime)
        visibilityRange = maxTime;
    else
        visibilityRange = i+windowSize;
    end
    
%     plot(realPoints(1,i:2:startTime+i), realPoints(2,i:2:startTime+i), 'r*', realPoints(1,i+1:2:startTime+i), realPoints(2,i+1:2:startTime+i), 'g*', errorPoints(1,:), errorPoints(2,:), 'b*');
    plot(realPoints(1,1:maxTime), realPoints(2,1:maxTime), 'k*', ...
         realPoints(1, i:visibilityRange), realPoints(2, i:visibilityRange), 'g*', ...
         errorPoints(1,:), errorPoints(2,:), 'r*', ...
         setsOfPoints(1, :, 1), setsOfPoints(2, :, 1), 'm+', ... 
         setsOfPoints(1, :, 2), setsOfPoints(2, :, 2), 'yo');
    
    xlim([-lim,lim]);
    ylim([-lim,lim]);
    
    subplot(2,1,2);
    plot(errorArray(1,:), errorArray(2,:));
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
clf
mean(errorArray(2,:))
end


