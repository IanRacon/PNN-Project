function [ score ] = comptScore( lifeTime, propability)
%returns Overall point score
MAX_TIME = 2*60; %minutes

score = ((MAX_TIME-lifeTime)/MAX_TIME)*0.5 + propability*0.5;

end

