clear all;
close all;
datafolder = '../../hw3bmaterials/problem1/';
load([datafolder 'A.mat'], '-ASCII');
load([datafolder 'epsilon.mat'], '-ASCII');
load([datafolder 'gamma.mat'], '-ASCII');
load([datafolder 'opinionpoll.mat'], '-ASCII');
load([datafolder 'prior.mat'], '-ASCII');
epsilon = epsilon';
prior = prior';
[S,R] = kalman(epsilon,gamma,opinionpoll,prior,A);
Rt = R{11};
save('results/variance.mat','Rt')