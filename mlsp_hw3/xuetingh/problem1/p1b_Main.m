%Matlab file for solving problem 1b.

% Assume that all data are in ../data/
%
%Running this code should:
%For each of the three measurements
%    a) Load the measurement matrix
%    b) Solve using the IHT algorithm
%    c) Print out the error of reconstruction
%    d) Save reconstructed image as  I_XXXXb.png


% Provide the IHT algorithm code itself in a separate file called iht.m
clear all;
close all;
measure_all = [];
measure_all{1} = '1639';
measure_all{2} = '2048';
measure_all{3} = '4096';
Error = zeros(1,3);
I = imread('../../hw3materials/problem1/cassini128.png');
I = im2double(I);
datapth = '../../hw3materials/problem1/data';
for k = 1:3
    measure = measure_all{k};
    P = load(fullfile(datapth,measure,['P' measure '.mat']));
    P = P.P;
    
    R = load(fullfile(datapth,measure,['R' measure '.mat']));
    R = R.R;
    
    S = load(fullfile(datapth,measure,['S' measure '.mat']));
    S = S.S;
    % compute F, recover image, show image, compute error, save recovered image
    M = size(P,1);
    N = size(R,2);
    K = floor(min(M/4,N/10));
    % choose the learning rate to be 0.2
    F = iht(P,R,K,0.2,200);
    Irec = waverec2(reshape(F,128,128),S,'db1');
%     save(['result/I_' measure 'b.mat'],'Irec');
    imagesc(Irec);
    colormap('Gray');
    E = 0.0;
    for i = 1:128
        for j = 1:128
            E = E+ (I(i,j) - Irec(i,j))^2;
        end
    end
    Error(k) = E;
end