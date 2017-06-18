function [ points ] = increaseTime( points )
pointsQuantity = size(points, 2);
global lifeTimeIndex;
for sampleIndex=1:pointsQuantity
    points(lifeTimeIndex, sampleIndex) = points(lifeTimeIndex, sampleIndex) + 1; %increase lifeTime
end
end

