%% Part 2.1: Capture Audio
clear all
close all
% @params add line
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
 plot([1:length(audio)]/Fs,audio), xlabel('time (s)'), ylabel('Amplitude');
 play(recorder);

% Save Audio Clip
save('audioclip.mat','audio','Fs','bits','channels', 'recordTime', '-append');

%% Part 2.2: Analyze Audio a
clear all
load audioclip.mat;
N = recordTime*Fs;
X_f = fft(audio); %freq domain of signal
mag = abs(X_f); %maginuted of ft signal
magdb = 10*log(mag); %db scale of the signal
f = linspace(-Fs/2,Fs/2, N); % creates a scaled frequency range to plot the magdb on
figure
% Will plot the magnitude of audio in dB versus freq in Hz
semilogy(f, fftshift(magdb), 'LineWidth', 2, 'color', 'b'), grid on, xlabel('Frequency [Hz]'), ylabel('Magnitude of Audio Signal [dB]');
hold on
[maxVal, freq] = max(mag); % finds maximum value on the magnitude plot 
fundamentalFreq = freq/recordTime; %fund freq. is the maximum on the graph.
xline(fundamentalFreq, 'LineWidth', 1, 'color', 'r'); % places a vertical line on the plot to illustrate the fundamental freq.