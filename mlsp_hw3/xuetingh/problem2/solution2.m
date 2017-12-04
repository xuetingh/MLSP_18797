%Matlab file for solving problem 1a.

% Assume that the image is in ../data/
% Running this code should:
%
% a) Load the measurement matrix
% b) Run the deblurring algorithm
% c) Print out the deblurred image into "deblurred.png"
% d) Plot the log likelihood of the data (blurry image) as a function of iterations into "likelihood.png"
clear all;
I = double(imread('../../hw3materials/problem2/carblurred.png'));
P_x2 = ones(20,1);
sum_x2 = 0.0;
for i = 1:20
    P_x2(i,1) = exp(0.1 * (1-i));
    sum_x2 = P_x2(i,1) + sum_x2;
end
P_x2 = double(P_x2 / sum_x2);
P_x1 = double(I) / (sum(sum(I)));
[P_x1, P_x2] = doEM(P_x1, P_x2, 50, I);
imshow(P_x1*1e5);
imwrite(P_x1*1e5,'result/deblur.png');
