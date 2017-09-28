function [T, E, smagMusicProj] = transcribe_music_gradient_descent(M, N, lr, num_iter)
% Input: 
%   M: (smagMusic) 1025 x K matrix containing the spectrum magnitueds of the music after STFT.
%   N: (smagNote) 1025 x 11 matrix containing the spectrum magnitudes of the notes.
%   lr: learning rate, i.e. eta as in the assignment instructions
%   num_iter: number of iterations
%   threshold: threshold

% Output:
%   T: (transMat) 11 x K matrix containing the transcribe coefficients.
%   E: num_iter x 1 matrix, error (Frobenius norm) from each iteration
%   transMatT: 11 x K matrix, threholded version of T (transMat) using threshold
%   smagMusicProj: 1025 x K matrix, reconstructed version of smagMusic (M) using transMatT
    W = zeros(15,8869);
    E = [];
    for i = 1:num_iter
        W = W - lr * 2 * N.'* (N * W - M) / 1025 /8869;
        W(W<0) = 0;
        E(i) = 1/1025/8869*norm(M-N*W,'fro');
    end
    T = W;
    smagMusicProj = N * T;