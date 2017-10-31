function [speech_recv, music_recv] = separate_signals(mixed_spec,Bmusic,Bspeech, niter)
B = [Bmusic, Bspeech];
W = rand(size(B,2),size(mixed_spec,2));
for i = 1:niter
    W = W .* (B' * mixed_spec) ./ (B' * (B * W));
end
Wm = W(1:200,:);
Ws = W(201:400,:);
speech_recv = Bspeech * Ws;
music_recv = Bmusic * Wm;
end