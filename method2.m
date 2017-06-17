clear all;

stepSize = 500;
startTime = stepSize*2;
windowSize = startTime;
maxTime = stepSize*2*8;
spread = 0.0001;


step = 1;

% points = zeros(2, maxTime);
points = zeros(5, maxTime, 2); % 5 point paramters, maxTime samples, 2 classes
targets = zeros(1, maxTime);
results = zeros(1, maxTime);
errorArray = zeros(2, 0);
spreadArray = zeros(2, 0);

errorPoints = zeros(2, 0);

class1Points = zeros(5, windowSize);
class2Points = zeros(5, windowSize);

for i = 1:maxTime;
    if mod(i,2) == 0;
        points(:,i) = generateClasss2PointSet(i/2, stepSize)';
        targets(i) = 1;
        results(i) = 1;
    else
        points(:,i) = generateClasss1PointSet((i+1)/2, stepSize)';
        targets(i) = 2;
        results(i) = 2;
    end
end
for i = 1:windowSize;
    if mod(i,2) == 0;
        class2Points(:, i) = points(:, i);
    else
        class1Points(:, i) = points(:, i);
    end
end

setsOfPoints = zeros(5, windowSize, 2);

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
    considerPoint(setsOfPoints, points(:, i));
    
    
%     results = vec2ind(net(points(:,i:startTime+i)));
    errorVector = abs(results(1:startTime+1) - targets(i:startTime+i));
    errorArray = [errorArray, [i; sum(errorVector)*100/step]];
    
    errorPoints = zeros(2, 0);
    for j = i:startTime+i
        if results(j-i+1) ~= targets(j)
            errorPoints = [errorPoints, points(:,j)];
        end
    end
    
%     spread = calculateSpread(points(i:startTime-step+i),targets(i:startTime-step+i),(startTime-step)/2, points(startTime-step+i+1:startTime+i),targets(startTime-step+1+i:startTime+i),(step)/2);
%     spreadArray = [spreadArray, [i; spread]];
    
    T = ind2vec(targets(i:startTime+i));
    net = newpnn(points(:,i:startTime+i), T, spread);

    
    subplot(3,1,1);
    lim = 10;
 
    plot(points(1,i:2:startTime+i), points(2,i:2:startTime+i), 'r*', points(1,i+1:2:startTime+i), points(2,i+1:2:startTime+i), 'g*', errorPoints(1,:), errorPoints(2,:), 'b*');
    xlim([-lim,lim]);
    ylim([-lim,lim]);
    
    subplot(3,1,2);
    plot(errorArray(1,:), errorArray(2,:));
    xlabel('ilosc dodanych punktow')
    ylabel('procent blednych punktow');
    
    subplot(3,1,3);
    plot(spreadArray(1,:), spreadArray(2,:));
    xlabel('ilosc dodanych punktow')
    ylabel('wartosc spread');
    
    
    drawnow;

end

mean(errorArray(2,:))


