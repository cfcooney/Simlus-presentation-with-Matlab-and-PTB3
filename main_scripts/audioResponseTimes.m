clear all
close all

subject = '01';
session = num2str(1);
directory = 'C:\Users\cfcoo\OneDrive - Ulster University\Study_3\Subject_Data\';
dirSaveLoad = [directory 'S' subject '\Session_' session '\triggeredData\'];
load([dirSaveLoad 'triggeredAudioTest.mat']);

audioData = triggeredAudio(1,:);
index = find(triggeredAudio(2,:));
classes = triggeredAudio(2,index);

seq = ones(1,200); % threshold for speech recognition
start = 2000; %0.25sec
stop = 18000;

for i = 1:96
    
    audiowrite('test.wav',audioData(start:stop),8000);
    
    fileReader = dsp.AudioFileReader('test.wav');
    fs = fileReader.SampleRate;
    fileReader.SamplesPerFrame = ceil(2.5e-3*fs);
    VAD = voiceActivityDetector('InputDomain','Time','SpeechToSilenceProbability',0.1,...
        'SilenceToSpeechProbability',0.2, 'Window','Hamming');
    
    p = [];
    while ~isDone(fileReader)
        audioIn = fileReader();
        probability = VAD(audioIn);
        p = [p,probability*ones(fileReader.SamplesPerFrame,1)'];
    end
    
    speech = strfind(p, seq);
    if isempty(speech) == 0
        onset = speech(1);
        time = onset / fs;
        times{i} = {classes(i), time};
    end
    
    start = start + 18000;
    stop = stop + 18000;
end

times = times(~cellfun('isempty',times));
meanResponse = get_mean_times(times);
writemcell(meanResponse,[dirSaveLoad '/meanResponses.xlsx'],'Sheet',1,'Range','A1')