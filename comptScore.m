function [ score ] = comptScore( lifeTime, propability, penalty, p_time, p_propability, p_penalty)
%returns Overall point score
MAX_TIME = 1*p_time; %minutes

score = ((MAX_TIME-lifeTime)/MAX_TIME)*0.5 + propability*p_propability - penalty*p_penalty;

end

