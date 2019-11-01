function [sessionTrials, condVector, stimValues, countVector] = get_session_trials(dir,subject,session,numSessions,numBlocks,numRuns, numTrials)
%----------------------------------------------------------------
% Function for returning trial class labels for a specific session.
% Inputs: - dir (str): directory for loading and saving
%         - subject (char): subject i.d. e.g. '01'
%         - session (char): session i.d. e.g. 'Session 1'   
%         - numSession (int): number of sessions in experiment
%         - numBlocks (int): total number of blocks in experiment
%         - numSession (int): total number of runs in experiment
%
% Outputs : - sessionTrials (cell array): Trial class labels for current
%             session, split into blocks and runs
%           - condVector (cell array): Total randomized class labels for 
%             all sessions, not split
%           - stimValues (cell array): Array containing single label for 
%             each class
%           - countVector (double): Double for recording how many of each 
%             class has been shown in the experiment

stimValues = regexp(fileread('classes.txt'), ';', 'split');
stimValues = erase(stimValues,"'");
numRepeats = numTrials; % number of trials per class.
if strcmp(session, '1')
    
    condVector = Shuffle(repmat(stimValues, 1, numRepeats));
    countVector = zeros(1, size(stimValues,2)); % vector for storing number of trials completed per class.

    totalTrials = split_trials(condVector,numSessions,numBlocks,numRuns);
    save([dir '\Subject_Data\S' subject '\condVector.mat'], 'condVector');
    save([dir '\Subject_Data\S' subject '\totalTrials.mat'], 'totalTrials');
    
    sessionTrials = totalTrials{1};
else
    totalTrials = load([dir '\Subject_Data\S' subject '\totalTrials.mat']);
    sessionTrials = totalTrials.totalTrials{2};
    condVector = load([dir '\Subject_Data\S' subject '\condVector.mat']);
    condVector = condVector.condVector;
    countVector = load([dir '\Subject_Data\S' subject '\Session_1\countVector.mat']);
    countVector = countVector.countVector;
end