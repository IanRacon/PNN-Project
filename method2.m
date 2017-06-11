clear all;

stepSize = 100;
startTime = stepSize*2;
maxTime = stepSize*2*8;
spread = 0.5;

step = 10;

points = zeros(2, maxTime);
targets = zeros(1, maxTime);
results = zeros(1, maxTime);
errorArray = zeros(1, maxTime);

chujowePunkty = zeros(2, 0);

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

T = ind2vec(targets(1:startTime));
net = newrbe(points(:,1:startTime), T, spread);


queueSize = startTime;
%inicjalizacja kolejki priorytetowej
priorityQueue = zeros(4, queueSize);
for i = 1:queueSize
    res = net(points(:,i));
    if targets(i) == vect2class(res)
        priority = getPriority(res);
    else
        priority = -getPriority(res);
    end
    
    priorityQueue(:,i) = [i, priority, points(:,i)'];
    
    priorityQueue = sortrows(priorityQueue',2)';
end


for i = 1:step:maxTime-startTime    
    errorPoints = zeros(2,0);
    for j = 1:step
        res = net(points(:,i+j));
        if targets(i) == vect2class(res)
            priority = getPriority(res);
        else
            errorArray(i) = errorArray(i) + 1;
            errorPoints = [errorPoints, points(:,i+j)];
            priority = -getPriority(res);
        end    
        priorityQueue(:,j) = [i+j, priority, points(:,i+j)'];
        
        priorityQueue = sortrows(priorityQueue',2)';
    end
    
    subplot(2,1,1);
    plot(priorityQueue(3,:), priorityQueue(4,:), 'b*');
    lim = 10;
    xlim([-lim,lim]);
    ylim([-lim,lim]);
    subplot(2,1,2);
    plot(errorArray(1:step:maxTime-startTime));
    drawnow;
end


%for i = 1:step:maxTime-startTime
%     results = vec2ind(net(points(:,i:startTime+i)));
%     errorVector = abs(results(1:startTime+1) - targets(i:startTime+i));
%     errorArray(i) = sum(errorVector);
%     
%     T = ind2vec(targets(i:startTime+i));
%     net = newpnn(points(:,i:startTime+i), T, spread);
% 
%     
%     
%     chujowePunkty = zeros(2, 0);
%     for j = i:startTime+i
%         if results(j-i+1) ~= targets(j)
%             chujowePunkty = [chujowePunkty, points(:,j)];
%         end
%     end
%     
%     subplot(2,1,1);
%     lim = 10;
%  
%     plot(points(1,i:2:startTime+i), points(2,i:2:startTime+i), 'r*', points(1,i+1:2:startTime+i), points(2,i+1:2:startTime+i), 'g*', chujowePunkty(1,:), chujowePunkty(2,:), 'b*');
%     xlim([-lim,lim]);
%     ylim([-lim,lim]);
%     
%     subplot(2,1,2);
%     plot(errorArray(1:step:maxTime-startTime));
%     drawnow;
% 
% end


