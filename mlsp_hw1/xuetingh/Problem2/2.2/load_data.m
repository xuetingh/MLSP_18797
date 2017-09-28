function [smagNote, smagMusic, sphaseMusic] = load_data()
%% Argument Descriptions
% Required Input Arguments:
% None

% Required Output Arguments:
% smagNote: 1025 x 11 matrix containing the mean spectrum magnitudes of the notes. A correct sequence of the notes is REQUIRED. (From left to right: e f g a b c d e2 f2 g2 a2)
% smagMusic: 1025 x K matrix containing the spectrum magnitueds of the music after STFT.

%% Load Spectrum Magnitudes of Notes
%compute the spectra for the notes 
notesfolder = 'notes15/';
listname =[];
listname{1} = '1C.wav';
listname{2} = '1D.wav';
listname{3} = '1E.wav';
listname{4} = '1F.wav';
listname{5} = '1G.wav';
listname{6} = '1A.wav';
listname{7} = '1B.wav';
listname{8} = '2C.wav';
listname{9} = '2D.wav';
listname{10} = '2E.wav';
listname{11} = '2F.wav';
listname{12} = '2G.wav';
listname{13} = '2A.wav';
listname{14} = '2B.wav';
listname{15} = '3C.wav';
smagNote = [ ];
for k = 1:15
    [s,fs] = audioread([notesfolder, listname{k}]);
    s = s(:,1);
    s = resample(s,16000,fs);
    spectrum = stft(s',2048,256,0,hann(2048));
    %Find the central frame
middle = ceil(size(spectrum,2)/2);
note = abs(spectrum(:,middle));
%Clean up everything more than 40db below the peak note(find(note < max(note(:))/100)) = 0;
note = note/norm(note);
%normalize the note to unit length
smagNote = [smagNote,note];
end
%% Load Spectrum Magnitues and Phases of The Provided Music
% Fill your code here to return 'smagMusic' and 'sphaseMusic'
%read polyushka into matlab 
[s,fs] = audioread('polyushka.wav');
s = resample(s,16000,fs);
%compute the spectrogram of a recording
spectrum = stft(s',2048,256,0,hann(2048));
smagMusic = abs(spectrum);
sphaseMusic = spectrum./(abs(spectrum)+eps);