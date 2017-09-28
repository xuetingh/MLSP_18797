function [smagMusic, sphaseMusic] = load_data(filename)
%% Argument Descriptions
% Required Input Arguments:
% Filename: the music file to extract

% Required Output Arguments:
% smagMusic:  matrix containing the spectrum magnitueds of the music after STFT.
% sphaseMusic:  matrix containing the spectrum phases of the music after STFT.

%% Load Spectrum Magnitues and Phases of The Provided Music
% Fill your code here to return 'smagMusic' and 'sphaseMusic'
%read polyushka into matlab 
[s,fs] = audioread(filename);
s = resample(s,16000,fs);
s1 = s(:,1);
%compute the spectrogram of a recording
spectrum = stft(s1',1024,256,0,hann(1024));
smagMusic = abs(spectrum);
sphaseMusic = spectrum./(abs(spectrum)+eps);