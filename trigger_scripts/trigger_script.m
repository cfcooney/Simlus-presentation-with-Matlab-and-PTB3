tic

clear all;
clc;
close all

%% Settings selection
% Paradigm settings
global fs
fs=500;
avover=1;               %average over how many trials
% numStim=2;              %total stim (always 2)
numChannels=64;         %channels used
trig_ch=numChannels+1;  %select channel for triggering

prompt = {'Please enter the subject number','Please enter the session number'};
dlgtitle = 'Subject/Session ID';
response = inputdlg(prompt, dlgtitle);
subject = char(response(1));
session = char(response(2));

dirLoadSave = ['C:\Users\sb00745777\OneDrive - Ulster University\Study_3\Subject_Data\S' subject '\Session_' session];

try

    load([dirLoadSave,'\EEG_rec.mat']);

catch
    disp(['NO DATA FOR SUB', subject])
end

EEG_rec(1,:) = []; % removes timestamp from array

PRE=round(fs*1-1);    %pre triggger - pretrial rest = 1 sec
PST=round(fs*4);      %post trigger - cue (1s); trial (1.5s); post (1.5s)

triggeredEEG = get_trigger(EEG_rec, PRE, PST);
save([dirLoadSave '/triggeredEEG.mat'], 'triggeredEEG');
toc
