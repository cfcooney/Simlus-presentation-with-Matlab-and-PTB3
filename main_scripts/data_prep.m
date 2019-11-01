% Name: Ciaran Cooney
% Date: 20/08/2019
% Description: Code for data prepartation:
% 1) Resize images to uniform dimensions.
% 2) Clip and concatenate audio files for 2-word presentation.

clear all
classes = fileread('classes.txt');
classes = regexp(classes, ";", 'split');

folder = 'C:\Users\sb00745777\OneDrive - Ulster University\Study_3\Matlab\';

%--Edit images to ensure uniform dimensions--%
image_folder = [folder 'images\'];
numrows = 325;
numcols = 325;
for i = 1:size(classes,2)
    if erase(classes{i}(end-5:end), "'") == 'image'
        image_resize(image_folder, erase(classes{i},"'"), numrows, numcols)
    end
end
clear classes image_folder numrows numcols 

%--Concatenate audio file to create 2-word prompts--%
audio_folder = [folder 'audio\'];
[red, fs] = audioread([audio_folder 'red' '.ogg']);
samples=[6000,length(red)-(0.1*fs)];
red1 = audioread([audio_folder 'red' '.ogg'],samples);

[blue, fs] = audioread([audio_folder 'blue' '.ogg']);
samples=[3500,length(blue)-(0.2*fs)];
blue1 = audioread([audio_folder 'blue' '.ogg'],samples);

[hat, fs] = audioread([audio_folder 'hat' '.ogg']);
samples=[3500,length(hat)-(0.3*fs)];
hat1 = audioread([audio_folder 'hat' '.ogg'],samples);

[ball, fs] = audioread([audio_folder 'ball' '.ogg']);
samples=[4500,length(ball)-(0.2*fs)];
ball1 = audioread([audio_folder 'ball' '.ogg'],samples);

redball = [red1;ball1];
bluehat = [blue1;hat1];
redblue = [red1;blue1];
ballhat = [ball1;hat1];

audiowrite([audio_folder 'redball.ogg'], redball,fs);
audiowrite([audio_folder 'bluehat.ogg'], bluehat,fs);
audiowrite([audio_folder 'redblue.ogg'], redblue,fs);
audiowrite([audio_folder 'ballhat.ogg'], ballhat,fs);


%--Mnaual clipping of audio to shorten length
[tiger, fs] = audioread([audio_folder 'tiger' '.ogg'],[15000 40000]);
audio = audioplayer(tiger,fs);

[animal, fs] = audioread([audio_folder 'animal' '.ogg'],[5000 30000]);
audiowrite([audio_folder 'animal.ogg'], animal,fs);

[apple, fs] = audioread([audio_folder 'apple' '.ogg'],[5000 25500]);
audiowrite([audio_folder 'apple.ogg'], apple,fs);

[bus, fs] = audioread([audio_folder 'bus' '.ogg'],[15000 40000]);
audiowrite([audio_folder 'bus.ogg'], bus,fs);

[car, fs] = audioread([audio_folder 'car' '.ogg'],[5000 25000]);
audiowrite([audio_folder 'car.ogg'], car,fs);

[chew, fs] = audioread([audio_folder 'chew' '.ogg'],[15000 36000]);
audiowrite([audio_folder 'chew.ogg'], chew,fs);

[dog, fs] = audioread([audio_folder 'dog' '.ogg'],[5000 25000]);
audiowrite([audio_folder 'dog.ogg'], dog,fs);

[fruit, fs] = audioread([audio_folder 'fruit' '.ogg'],[5000 25000]);
audiowrite([audio_folder 'fruit.ogg'], fruit,fs);

[jump, fs] = audioread([audio_folder 'jump' '.ogg'],[13000 35000]);
audiowrite([audio_folder 'jump.ogg'], jump,fs);

[kick, fs] = audioread([audio_folder 'kick' '.ogg'],[4000 21000]);
audiowrite([audio_folder 'kick.ogg'], kick,fs);

[pig, fs] = audioread([audio_folder 'pig' '.ogg'],[5000 21000]);
audiowrite([audio_folder 'pig.ogg'], pig,fs);

