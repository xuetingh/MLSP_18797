clear
%% Load mixed signals
% Define matrix M
[s1,fs1] = audioread('problem3/sample1.wav');
[s2,fs2] = audioread('problem3/sample2.wav');
data = [s1';s2'];
mean_data = mean(data,2);
M = data - mean_data;
%% Compute ICA
% use ica function
H = ica(M);
%% Save results
% Use 'wavwrite' function to write results
% Normalize matrix to automatically adjust the volume
Y1 = H(1,:);
Y2 = H(2,:);
Ym = max(abs(Y1));
X1 = Y1/Ym; 
Ym2 = max(abs(Y2));
X2 = Y2/Ym2;
% normalized audios
audiowrite('results/source1.wav',X1,fs1);
audiowrite('results/source2.wav',X2,fs2);
%% 4. calculate errors
Sp = load ('problem3/spectograms.mat');
S1 = Sp.S1;
S2 = Sp.S2;
[R1, R2] = load_data();
error1 = min(norm(S1 - R1, 'fro') , norm(S1 - R2, 'fro'));
error2 = min(norm(S2 - R1, 'fro') , norm(S2 - R2, 'fro'));
