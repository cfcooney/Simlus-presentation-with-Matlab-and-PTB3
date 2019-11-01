function conditions = split_trials(condVector,numSessions,numBlocks,numRuns)
%----------------------------------------------------------------
% Function for splitting trial-prompts by session, block and run.
% Inputs: condVector (cell array): randomized trial-prompts.
%         numSessions (int): number of sessions in experiment
%         numBlocks (int): number of blocks  
%         numRuns (int): number of runs
%
% Output : conditions (cell array): Nested cell array containing trials-per
%          -run, trials-per-block and trials per-session.

runCond = {};
i = 1;
j = size(condVector,2) / numRuns;
for run = 1:numRuns
    runCond{run} = condVector(i:j);
    i = i + size(condVector,2) / numRuns;
    j = j + size(condVector,2) / numRuns;
end

blockCond = {};
i = 1;
j = numRuns / numBlocks;
for block = 1:numBlocks
    blockCond{block} = runCond(i:j);
    i = i + size(runCond,2) / numBlocks;
    j = j + size(runCond,2) / numBlocks;
end

conditions = {};
i = 1;
j = numBlocks / numSessions;
for session = 1:numSessions
    conditions{session} = blockCond(i:j);
    i = i + size(blockCond,2) / numSessions;
    j = j + size(blockCond,2) / numSessions;
end

