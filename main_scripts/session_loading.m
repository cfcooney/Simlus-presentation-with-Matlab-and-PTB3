% Clear the workspace and the screen
close all;
clearvars;
sca

dir = 'C:\Users\sb00745777\OneDrive - Ulster University\Study_3';

subject = inputdlg('Please enter the subject number','Subject ID');
subject = char(subject);

session = questdlg('Session One or Two?', 'Session Number', '1', '2', '1');

numSessions = 2;
numBlocks = 6;
numRuns = 12; % total across sessions
numTrials = 1; % trials per class
[sessionTrials, condVector, stimValues, countVector] = get_session_trials(dir,subject,session,numSessions,numBlocks,numRuns, numTrials); % compute or load session trials


%% Set up Screen
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', 1, grey);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

fixCrossDimPix = 150;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 8;
audioImage = imread('C:\Users\sb00745777\OneDrive - Ulster University\Study_3\Matlab\audio\audio.jpg');

Screen('TextSize', window, 80);
Screen('TextFont', window, 'Courier');


%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

DrawFormattedText(window, 'Press Any Key To Begin Session', 'center', 'center', white);
Screen('Flip', window);
KbStrokeWait;
tic

for block = 1:numBlocks / numSessions
    blockTrials = sessionTrials{block};
    DrawFormattedText(window, ['Press Any Key To Begin Block' block], 'center', 'center', white);
    Screen('Flip', window);

    KbStrokeWait;
    for run = 1:numRuns / numBlocks
        runTrials = blockTrials{run}(1:2);

        DrawFormattedText(window, 'Run Begins in 3', 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(1);
        DrawFormattedText(window, 'Run Begins in 2', 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(1);
        DrawFormattedText(window, 'Run Begins in 1', 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(1);
       
        for trial = 1:size(runTrials,2)

            % Draw the fixation cross in white, set it to the center of our screen and
            % set good quality antialiasing
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, white, [xCenter yCenter], 2);
            Screen('Flip', window);
            WaitSecs(0.5);
            imageArray = Screen('GetImage', window);
            %imwrite is a Matlab function, not a PTB-3 function
            imwrite(imageArray, strcat('cross', '.jpg'))
            %randomIndex = randi(size(prompts, 1));
            prompt = get_prompt(runTrials{trial});

            if isa(prompt, 'char') == 1  
                DrawFormattedText(window, prompt, 'center', 'center', white);
            elseif isa(prompt, 'uint8') == 1  
                imageTexture = Screen('MakeTexture', window, prompt);
                Screen('DrawTexture', window, imageTexture, [], [], 0);
                else 
                    imageTexture = Screen('MakeTexture', window, audioImage);
                    Screen('DrawTexture', window, imageTexture, [], [], 0);
                    play(prompt);
            end

            Screen('Flip', window);
            %imageArray = Screen('GetImage', window);
            %imwrite is a Matlab function, not a PTB-3 function
            %imwrite(imageArray, strcat('test', num2str(block), num2str(run), num2str(trial), '.jpg'))
            WaitSecs(1);

            % Beep to begin production
            Beeper();
            % No fixation cross during production
            Screen('FillRect', window, [0.5 0.5 0.5]);
            Screen('Flip', window);
            imageArray = Screen('GetImage', window);
            %imwrite is a Matlab function, not a PTB-3 function
            imwrite(imageArray, strcat('blank', '.jpg'))
            WaitSecs(1.5);

            % Beep to end task production
            Beeper();
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, white, [xCenter yCenter], 2);
            Screen('Flip', window);
            r = 1.5 + (2.5-1.5) .* rand(1,1); % random number for post-trial timing
            WaitSecs(r);

            Screen('FillRect', window, [0.5 0.5 0.5]);

            countVector(find(strcmp(stimValues, condVector{trial}))) = countVector(find(strcmp(stimValues, condVector{trial}))) + 1;

        end
        if run < numRuns / numBlocks
            DrawFormattedText(window, ['Run' run ' complete...' newline 'press any key to continue'], 'center', 'center', white);
            Screen('Flip', window);
            KbStrokeWait;
        end
    end
    DrawFormattedText(window, ['Block' block ' complete...press any key'], 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait;
end
% @ end of session save countVector
%session_folder = strrep(session, ' ', '_');

%imageArray = Screen('GetImage', window);
% imwrite is a Matlab function, not a PTB-3 function
%imwrite(imageArray, 'test.jpg')

save([dir '\Subject_Data\S' subject '\Session_' session '\countVector.mat'], 'countVector');
DrawFormattedText(window, 'Session Complete...press any key', 'center', 'center', white);
Screen('Flip', window);

KbStrokeWait;
Screen('Close',window)
sca;
toc













