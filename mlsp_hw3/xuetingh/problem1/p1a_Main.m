%Matlab file for solving problem 1a.

% Assume that all data are in ../data/
%Running this code should:
%
%For each of the three measurements
%    a) Load the measurement matrix
%    b) Solve
%    c) Print out the error of reconstruction
%    d) Save reconstructed image as  I_XXXXa.png
% measure_all = ['1639'; '2048'; '4096'];
measure_all = [];
measure_all{1} = '1639';
measure_all{2} = '2048';
measure_all{3} = '4096';
E = zeros(1,3);
I = imread('../../hw3materials/problem1/cassini128.png');
I = im2double(I);
% I = double(I);
for k = 1:3
    measure = measure_all{k};
    datapth = '../../hw3materials/problem1/data';
    P = load(fullfile(datapth,measure,['P' measure '.mat']));
    P = P.P;
    
    R = load(fullfile(datapth,measure,['R' measure '.mat']));
    R = R.R;
    
    S = load(fullfile(datapth,measure,['S' measure '.mat']));
    S = S.S;
    
    % compute F, recover image, show image, compute error, save recovered image
    F = p1a_getF(P, R, 100);
    % load SXXXX.mat;
    % S = SXXXX;
    Irec = waverec2(reshape(F,128,128),S,'db1');
    error = 0.0;
    for i = 1:128
        for j = 1:128
            error = error + (I(i,j) - Irec(i,j)) * (I(i,j) - Irec(i,j));
        end
    end
    E(k) = error;
    imshow(Irec);
    imwrite(Irec,['result/I_' measure 'a.png']);
    save(['result/I_' measure 'a.mat'], 'Irec');
end