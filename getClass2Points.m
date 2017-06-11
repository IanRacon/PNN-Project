function [point] = getClass2Points(radius, angle)
    point = generateRandomPoint(radius*cos(angle), radius*sin(angle));
end

