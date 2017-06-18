function [point] = generateRandomPoint(xCenter, yCenter)
    global pointAttribsCount;
    x = normrnd(xCenter,1);
    y = normrnd(yCenter,1);
    point = zeros(pointAttribsCount, 1);
    point(1) = x;
    point(2) = y;
%     point = [normrnd(xCenter,1), normrnd(yCenter,1)];
    %point = [xCenter, yCenter];
end

