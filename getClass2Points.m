function [point] = getClass2Points(radius, angle, x, y)
    point = generateRandomPoint(radius*cos(angle)+x, radius*sin(angle)+y);
end

