
%% Part 2.1: Capture Audio
clear all
close all
% @params
devinfo = audiodevinfo;
speaker = devinfo.output(1).ID;
mic = devinfo.input(2).ID;
Fs = 8000;
bits = 16;
channels = 1;
recordTime = 10;

% Recorder Object
recorder = audiorecorder(Fs, bits, channels, mic);
disp('Record begin');
recordblocking(recorder, recordTime);
disp('Record finish');
audio = getaudiodata(recorder);
% plot([1:length(audio)]/Fs,audio), xlabel('time (s)'), ylabel('Amplitude');
% play(recorder);

% Save Audio Clip
save('audioclip.mat','audio','Fs','bits','channels', 'recordTime', '-append');

%% Part 2.2: Analyze Audio
clear all
load audioclip.mat;
N = recordTime*Fs;
X_f = fft(audio);
mag = abs(X_f);
f = linspace(-1/2*Fs,1/2*Fs, N);
figure
semilogy(f, fftshift(mag)), grid on, xlabel('Frequency [Hz]'), ylabel('Magnitude of Audio Signal [dB]');


