function [O,A,gamma] = correct_size(opinionpoll,A_full,gamma_full, n)
%% input
%  opinionpoll 51*11
%  A_full      51*3
%  gamma_full  2*51
%  n           the column we want to process
%% output
%  O           51*1
%  A           51*3
%  gamma       51*2

%% function
O = [];
A = [];
gamma = [];
opinion = opinionpoll(:, n);
for i = 1:51
    if isnan(opinion(i))
        continue;
    else
        O = [O; opinion(i)];
        A = [A; A_full(i, :)];
        gamma = [gamma, gamma_full(:, i)];
    end
end
gamma = gamma';