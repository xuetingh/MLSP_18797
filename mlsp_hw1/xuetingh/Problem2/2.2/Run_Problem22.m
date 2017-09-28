%% Load Notes and Music
% You may reuse your 'load_data' function from prob 2.1
[smagNote, smagMusic, sphaseMusic] = load_data();
%% Compute The Transcribe Matrix: non-negative projection with gradient descent
% Use the 'transcribe_music_gradient_descent' function here
x = 1:1000;
lr = [100, 1000, 10000, 100000];
allE = [];
for i = 1:4 
eta = 10^(i+1);
[T, E, smagMusicProj] = transcribe_music_gradient_descent(smagMusic, smagNote, eta, 1000);
% Store final W for each eta value in a text file called "problem222_eta_xxx.dat"
% where xxx is the actual eta value. E.g. for eta = 0.01, xxx will be "0.01".
dlmwrite(['results/problem222_eta_' num2str(eta) '.dat'],T);
% Print the plot of E vs. iterations for each eta in a file called
% "problem222_eta_xxx_errorplot.png", where xxx is the eta value.
plot(x,E);
saveas(gcf,['results/problem222_eta_' num2str(eta) '_errorplot.png']);
allE(i) = E(1000);
end

% Print the eta vs. E as a bar plot stored in "problem222_eta_vs_E.png".
c = categorical({'eta=100','eta=1000','eta=10000','eta=100000'});
bar(c,allE);
bar(allE, 0.4);
saveas(gcf,'results/problem222_eta_vs_E.png');

%% Synthesize Music
% You may reuse the 'synthesize_music' function from prob 2.1
% T is calculated by eta=100000, this is the T with least error
smagMusicProj = smagNote * T;
synMusic = synthesize_music(sphaseMusic,smagMusicProj);
% Use 'wavwrite' function to write the synthesized music as 'problem212_synthesis.wav' to the 'results' folder.
audiowrite('results/polyushaka_syn.wav',synMusic,16000);