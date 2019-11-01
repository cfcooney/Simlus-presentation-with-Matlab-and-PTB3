function audio = get_audio(name)
folder = 'C:\Users\sb00745777\OneDrive - Ulster University\Study_3\Matlab\audio\';
if strcmp(name,'blink')
    [y, Fs] = audioread([folder name '.mp3']);
    audio = audioplayer(y,Fs);
else
    [y, Fs] = audioread([folder name '.ogg']);
    audio = audioplayer(y,Fs);
end