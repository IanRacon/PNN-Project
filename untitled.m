clear all;
steps = 200;
windowSize = 60;
spread = 0.1;
divider = 40;

data = zeros(2, steps);
targets = zeros(1, steps);
results = zeros(1, steps);


for t = 1:steps
    if mod(t,2) == 0
        targets(t) = 1;
        results(t) = 1;
        data(:,t) = getData(t, divider, [0,0]);
    else
        targets(t) = 2;
        results(t) = 2;
        data(:,t) = getData(t, divider, [1.5,1]);
    end
end

hold on
plot(data(1,:), data(2,:), '*r');




T = ind2vec(targets(1:windowSize));
net = newpnn(data(:,1:windowSize), T, spread);

for i = 1:steps-windowSize
    x = data(:,windowSize+i);
    results(windowSize+i) = vec2ind(net(x));
    
    T = ind2vec(results(i:windowSize+i));
    net = newpnn(data(:,i:windowSize+i), T, spread);
end

errors = 0;
errorStart = -1;
for i = windowSize+1:steps
    if results(i) ~= targets(i)
        errors = errors + 1;
        if errorStart == -1
            errorStart = i;
        end
    end
end

if errorStart ~= -1
    plot(data(1,errorStart:steps), data(2,errorStart:steps), '+b');
    plot(data(1,errorStart-windowSize:errorStart), data(2,errorStart-windowSize:errorStart), '+g');
end

hold off
    