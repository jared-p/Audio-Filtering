%% Part 4.1: Noise Signal 
clear all
close all
load audioclip.mat; % change to voiceclip.mat
N = recordTime*Fs;
noise = audio + randn(N,1);
X_f = fft(noise);
mag = abs(X_f);
magdb = 10*log(mag);
f = linspace(-Fs/2,Fs/2, N);
figure
semilogy(f, fftshift(magdb), 'color', 'b'), grid on, xlabel('Frequency [Hz]'), ylabel('Magnitude of Audio Signal [dB]');