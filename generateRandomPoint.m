function [point] = generateRandomPoint(xCenter, yCenter)
    point = [normrnd(xCenter,1), normrnd(yCenter,1)];
    %point = [xCenter, yCenter];
end

