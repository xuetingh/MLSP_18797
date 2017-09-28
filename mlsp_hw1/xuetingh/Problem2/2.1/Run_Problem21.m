%% Load Notes and Music
% Use the 'load_data' function here
[smagNote, smagMusic, sphaseMusic] = load_data();
a = norm(smagNote(1:1025,1),'fro');

%% Solution for Problem 2.1.1 here
% Store W in a text file called "problem211.dat"
W = pinv(smagNote) * smagMusic;
dlmwrite('results/problem211.dat',W);
%% Solution to Problem 2.1.2 here:  Synthesize Music
W (W < 0) = 0;
smagMusicProj = smagNote * W;
% Use the 'synthesize_music' function here.
synMusic = synthesize_music(sphaseMusic,smagMusicProj);
% Use 'wavwrite' function to write the synthesized music as 'problem212_synthesis.wav' to the 'results' folder.
audiowrite('results/problem212_synthesis.wav',synMusic,16000);