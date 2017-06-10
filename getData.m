function [point] = getData(t, divider, center)
    t = t/divider;  
    radius = 2;   
    noise = 0.3;
    point = center + [sin(t)*radius, cos(t)*radius] + [rand*noise, rand*noise];
end

