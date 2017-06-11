clear all;

stepSize = 500;
startTime = stepSize*2;
maxTime = stepSize*2*8;
spread = 0.0001;


step = 100;

points = zeros(2, maxTime);
targets = zeros(1, maxTime);
results = zeros(1, maxTime);
errorArray = zeros(2, 0);

errorPoints = zeros(2, 0);

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
T = ind2vec(targets(1:startTime));
net = newpnn(points(:,1:startTime), T, spread);

for i = 1:step:maxTime-startTime   
    results = vec2ind(net(points(:,i:startTime+i)));
    errorVector = abs(results(1:startTime+1) - targets(i:startTime+i));
    errorArray = [errorArray, [i; sum(errorVector)*100/step]];
    
    errorPoints = zeros(2, 0);
    for j = i:startTime+i
        if results(j-i+1) ~= targets(j)
            errorPoints = [errorPoints, points(:,j)];
        end
    end
    
    T = ind2vec(targets(i:startTime+i));
    net = newpnn(points(:,i:startTime+i), T, spread);

    
    subplot(2,1,1);
    lim = 10;
 
    plot(points(1,i:2:startTime+i), points(2,i:2:startTime+i), 'r*', points(1,i+1:2:startTime+i), points(2,i+1:2:startTime+i), 'g*', errorPoints(1,:), errorPoints(2,:), 'b*');
    xlim([-lim,lim]);
    ylim([-lim,lim]);
    
    subplot(2,1,2);
    plot(errorArray(1,:), errorArray(2,:));
    xlabel('ilosc dodanych punktow')
    ylabel('procent blednych punktow');
    drawnow;

end

mean(errorArray(2,:))


