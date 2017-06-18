function [ score ] = comptScore( lifeTime, propability, penalty)
%returns Overall point score
MAX_TIME = 2*60; %minutes

score = ((MAX_TIME-lifeTime)/MAX_TIME)*0.5 + propability*0.5 - penalty*0.1;

end

