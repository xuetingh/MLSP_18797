function [shat,P] = kalman(epsilon, gamma_full, opinionpoll, prior, A_full)
%kalman
n_iter = 11;
Q = zeros(3,3);
for i = 1:3
    Q(i,i) = epsilon(i,2);
end
shat = zeros(3,11);
shatminus = zeros(3,11);
Pminus = [];
% intial guesses
shat(:,1) = prior(:,1);
P{1} = zeros(3,3);
for i = 1:3
    P{1}(i,i) = prior(i,2);
end
for k = 2:n_iter
    [O,A,gamma] = correct_size(opinionpoll,A_full,gamma_full, k);
    n = size(O,1);
    R = zeros(n,n);
    for i = 1:n
        R(i,i) = gamma(i,2);
    end
    shatminus(:,k) = shat(:,k-1);
    Pminus{k} = P{k-1}+Q;
    K = Pminus{k}*A'/(A*Pminus{k}*A'+R);
    shat(:,k) = shatminus(:,k)+K*(O-A*shatminus(:,k)-gamma(:,1));
    P{k} = (eye(3)-K*A)*Pminus{k};
end
FontSize=10;
LineWidth=1;
figure();
plot(shat(1,:),'LineWidth',LineWidth)
hold on;
plot(shat(2,:),'LineWidth',LineWidth)
hold on;
plot(shat(3,:),'LineWidth',LineWidth)
legend('Clinton', 'Trump', 'Johnson');
xl=xlabel('Time');
yl=ylabel('The Estimated State');
set(xl,'fontsize',FontSize);
set(yl,'fontsize',FontSize);
saveas(gcf,'results/result.png');
save('results/state.mat','shat');