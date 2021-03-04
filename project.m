clear all
close all
% @params
devinfo = audiodevinfo;
speaker = devinfo.output(1).ID;
mic = devinfo.input(2).ID;
Fs = 8000;
bits = 16;
channels = 1;
recordTime = 1;

% Recorder Object
recorder = audiorecorder(Fs, bits, channels, mic);
disp('Record begin');
recordblocking(recorder, recordTime);
disp('Record finish');
audio = getaudiodata(recorder);
% plot([1:length(audio)]/Fs,audio), xlabel('time (s)'), ylabel('Amplitude');
% play(recorder);

% Save Audio Clip
save('audioclip.mat','audio','Fs','bits','channels');