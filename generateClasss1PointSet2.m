function [point] = generateClasss1PointSet2(iter, stepSize)
    if mod(iter,2) == 0
        point = generateRandomPoint(-2,0);
    else
        point = generateRandomPoint(2,0);
    end
end

