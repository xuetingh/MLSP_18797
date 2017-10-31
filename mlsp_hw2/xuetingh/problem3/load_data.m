function [smag1, smag2] = load_data()
%% Argument Descriptions
% Required Input Arguments:
% None

[s,fs] = audioread('results/source1.wav');
[s2,fs2] = audioread('results/source2.wav');
%compute the spectrogram of a recording
spectrum1 = stft(s',2048,256,0,hann(2048));
spectrum2 = stft(s2',2048,256,0,hann(2048));
smag1 = abs(spectrum1);
smag2 = abs(spectrum2);
