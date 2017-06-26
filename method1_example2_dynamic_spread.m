clear all;

globals;
pointAttribsCount = 8;
penaltyIndex = 7;
propabilityIndex = 6;
lifeTimeIndex = 5;
classOfPointIndex = 4;
serialNumberIndex = 3;
serialNumber = 1;
logsEnabled = false;


stepSize = 500;
startTime = stepSize*2;
maxTime = stepSize*2*17;
spread = 1;


step = 100;

points = zeros(8, maxTime);
targets = zeros(1, maxTime);
results = zeros(1, maxTime);
errorArray = zeros(2, 0);
spreadArray = zeros(2, 0);

errorPoints = zeros(2, 0);

for i = 1:maxTime;
    if mod(i,2) == 0;
        points(:,i) = generateClasss2PointSet2(i/2, stepSize)';
        targets(i) = 1;
        results(i) = 1;
    else
        points(:,i) = generateClasss1PointSet2((i+1)/2, stepSize)'; 
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

for i = 1:step:maxTime-step   
    results = vec2ind(net(points(:,i:step+i)));
    errorVector = abs(results(1:step+1) - targets(i:step+i));
    errorArray = [errorArray, [i; sum(errorVector)*100/step]];
    
    errorPoints = zeros(8, 0);
    for j = i:step+i
        if results(j-i+1) ~= targets(j)
            errorPoints = [errorPoints, points(:,j)];
        end
    end
    
    T = ind2vec(targets(i:step+i));
    
    c_it = 0;
    for c = i:step+i
       if( targets(c) == 1)
           c_it = c_it + 1;
       end
    end
    spread = calculateSpread( points(:,i:step+i-1), targets(:, i:step+i-1), c_it-1, points(:,i:step+i-1), targets(:, i:step+i-1), c_it-1 );
    spreadArray = [spreadArray, [i; spread]];
    net = newpnn(points(:,i:step+i), T, spread);

    
    subplot(3,1,1);
    lim = 10;
 
    plot(points(1,i:2:step+i), points(2,i:2:step+i), 'r*', points(1,i+1:2:step+i), points(2,i+1:2:step+i), 'g*', errorPoints(1,:), errorPoints(2,:), 'b*');
    xlim([-lim,lim]);
    ylim([-lim,lim]);
    
    subplot(3,1,2);
    plot(errorArray(1,:), errorArray(2,:));
    xlabel('ilosc dodanych punktow')
    ylabel('procent blednych punktow');
    drawnow;
    
    subplot(3,1,3);
    plot(spreadArray(1,:), spreadArray(2,:));
    xlabel('ilosc dodanych punktow')
    ylabel('wartosc spread');
    drawnow;

end

mean(errorArray(2,:))


