%% Load Music
% Use the 'load_data' function here
[smagPianoSN, sphasePianoSN] = load_data('audio/silentnight_piano.aif');
[smagPianoLS, sphasePianoLS] = load_data('Audio/littlestar_piano.aif');
[smagGuitarSN, sphaseGuitarSN] = load_data('Audio/silentnight_guitar.aif');
%% Learn magnitude
magW = smagGuitarSN * pinv (smagPianoSN);
smagGuitarLS = magW * smagPianoLS;
%% Learn phase
phaseW = sphaseGuitarSN * pinv (sphasePianoSN);
sphaseGuitarLS = phaseW * sphasePianoLS;
%% Get guitar version
[synMusic] =synthesize_music(sphaseGuitarLS,smagGuitarLS);
audiowrite('results/problem23_audio.wav',synMusic,16000);
