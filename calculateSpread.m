function [ sigma ] = calculateSpread( train, trainTarget, trainClassSize, test, testTarget, testClassSize )
maxSteps = 10;
epsilon = 0.005;
gamma = 0.95;
alpha = 0.01;

actions = [ -0.1, -0.01, -0.001, 0.001, 0.01, 0.1];
actionsCount = length(actions);

samplesCount = size(test, 2);
% classesCount = size(trainTarget, 1);
% attributesCount = size(train, 1);

% minimumSpread = 1;%ones(classesCount, attributesCount);
sigma = 1;%ones(classesCount, attributesCount);

% action values
Q = zeros(samplesCount, actionsCount);%zeros(samplesCount, classesCount, attributesCount, actionsCount);

%reinforcement value for every action
r = zeros(1, actionsCount);%zeros(classesCount, attributesCount, actionsCount);

%delta for evert action
delta = zeros(1, actionsCount);%zeros(classesCount, attributesCount, actionsCount);

%states
SSE = 0;%zeros(classesCount, attributesCount)

%statesOld
SSEOld = 0;%zeros(classesCount, attributesCount)

%stateMinimum
SSEMin = acc(test, testTarget, sigma, testClassSize);

%spreadIterations
maxSpread = 10;
SSEOfSpreads = zeros(1, maxSpread);

for spread=1:maxSpread
%     sigma = spread;
    SSEOfSpreads(spread) = acc(test, testTarget, spread, testClassSize);
end

[minVal, minSSEofSpreadInd] = min(SSEOfSpreads);

% minSSEofSpreadInd = 1;
% minSSEofSpread = SSEOfSpreads(minSSEofSpreadInd);
% 
% for i = 1:maxSpread
%     if(SSEOfSpreads(i) < minSSEofSpread)
%         minSSEofSpread = SSEOfSpreads(i);
%         minSSEofSpreadInd = i;
%     end
% end

spreadStart = minSSEofSpreadInd + 1;
nextBoxSize = getBoxSize(SSEMin, samplesCount);
% spreadCandidates = zeros(1, maxSteps);
% rCandidates = zeros(maxSteps, actionsCount);
% boxStart = nextBoxSize;
for step = 1 : maxSteps+1
%     box_old = box;
    box = nextBoxSize;
    maxQ = Q(box, 1);
    for i=2:actionsCount
       if(Q(box, i) > maxQ)
          maxQ = Q(box, i); 
       end
    end
    consideredActions = [];
    for i=1:actionsCount
       if(Q(box, i) == maxQ)
          consideredActions = [consideredActions , i];
       end
    end
    if(rand > epsilon)
        indexOfAction = consideredActions(randi(length(consideredActions)));
    else
        indexOfAction = randi(length(actions));
    end
    spreadOld = sigma;
    sigma = sigma + actions(indexOfAction);
    if(sigma <= 0)
        if(spreadOld == 0)
            sigma = spreadStart;
        else
            sigma = spreadOld;
        end
    end
    SSEOld = SSE;
    SSE = acc(train, trainTarget, sigma, trainClassSize);
%     SSETest = acc(test, testTarget, sigma, testClassSize);
    nextbox = getBoxSize(SSEMin, samplesCount);
    if( step ~= 1)
        r(indexOfAction) = SSEOld - SSE;
    else
        r(indexOfAction) = 0;
    end
    if(SSE < SSEMin)
        SSEMin = SSE;
%         minimumSpread = sigma;
    end
    maxQ = Q(nextbox, 1);
    for i = 2:actionsCount
       if(Q(box, i) > maxQ)
           maxQ = Q(box, i);
       end
    end
    delta(indexOfAction) = r(indexOfAction) + gamma*maxQ-Q(box, indexOfAction);
%     spreadCandidates(step) = sigma;
%     for i=1:actionsCount
%         rCandidates(step, i) = r(i);
%     end
    Q(box, indexOfAction) = Q(box, indexOfAction) + alpha*delta(indexOfAction);
end
end

