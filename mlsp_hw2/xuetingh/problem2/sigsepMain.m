[musicw,fs1] = audioread('problem2/musicf1.wav');
[speechw,fs2] = audioread('problem2/speechf1.wav');
[mixedw,fs3] = audioread('problem2/mixedf1.wav');

% resample
musicw = resample(musicw,16000,fs1);
speechw = resample(speechw,16000,fs2);
mixedw = resample(mixedw,16000,fs3);

music_spec = stft(musicw',2048,256,0,hann(2048));
speech_spec = stft(speechw',2048,256,0,hann(2048));
mixed_spec = stft(mixedw',2048,256,0,hann(2048));

% ADD CODE TO COMPUTE MAG. SPECTOROGRAMS OF MUSIC AND SPEECH
smag1 = abs(music_spec);
smag2 = abs(speech_spec);
% ADD CODE TO CPMPUTE MAG. SPECTROGRAM AND PHASE OF MIXED
smag3 = abs(mixed_spec);
sphase = mixed_spec ./ (smag3 + eps);
K = 200;
niter = 250;
B1 = load('problem2/Bminit.mat');
Bminit = B1.Bm;
W1 = load('problem2/Wminit.mat');
Wminit = W1.Wm;
B2 = load('problem2/Bsinit.mat');
Bsinit = B2.Bs;
W2 = load('problem2/Wsinit.mat');
Wsinit = W2.Ws;
Bm = doNMF(smag1,K,niter,Bminit,Wminit);
Bs = doNMF(smag2,K,niter,Bsinit,Wsinit);
save('results/Bm.mat','Bm');
save('results/Bs.mat','Bs');
% ADD CODE TO SEPARATE SIGNALS
% INITIALIZE WEIGHTS INSIDE separate_signals using rand() function
[speech_recv, music_recv] = separate_signals(smag3,Bm,Bs,niter);
% ADD CODE TO MULTIPLY BY PHASE AND RECONSTRUCT TIME DOMAIN SIGNAL
[synMusic] = synthesize_music(sphase,music_recv);
[synSpeech] = synthesize_music(sphase,speech_recv);

% WRITE TIME DOMAIN SPEECH AND MUSIC USING audiowrite with 16000 sampling
% frequency
audiowrite('results/music.wav',synMusic,16000);
audiowrite('results/speech.wav',synSpeech,16000);



