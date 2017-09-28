function [synMusic] = synthesize_music(sphaseMusic,smagMusicProj)
%% Argument Descriptions
% Required Input Arguments:
% sphaseMusic: 1025 x K matrix containing the spectrum phases of the music after STFT.
% smagMusicProj: 1025 x K matrix, reconstructed version of smagMusic using transMatT

% Required Output Arguments:
% synMusic: N x 1 music signal reconstructed using STFT.

%% Music synthesis
synMusic = stft(smagMusicProj.*sphaseMusic,1024,256,0,hann(1024));