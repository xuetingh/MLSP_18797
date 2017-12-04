function [P_x1, P_x2] = doEM(P_x1, P_x2, niter, I)
for i = 1:niter
    P_x1_old = P_x1;
    %% Estimation
    % calculate P(X2=N,X1=X-N,Y|X,Y) 20*288*531
    P_x2x1y_xy = [];
    sum_x2 = zeros(size(P_x2));
    sum_x1 = zeros(size(P_x1));
    % X2
    for j = 1 : 20
        P_x2x1y_xy{j} = zeros(size(I));
        % X1
        for k = 1 : size(I,1)
            for l = 1 : size(I,2)
                if(j <= l)
                    % Let's pretend P_x1(x,y) = P(x,y) since the P_x1 is
                    % pretty close to the distribution of the 'real' image
%                     if ( P_x1(k,l) ~= 0)
%                         P_x2x1y_xy{j}(k, l) = P_x2(j,1) * P_x1(k,l-j+1) / P_x1(k,l);
%                     else
%                         P_x2x1y_xy{j}(k, l) = P_x2(j,1);
%                     end
                    P_x2x1y_xy{j}(k, l) = P_x2(j,1) * P_x1(k,l-j+1);
                    sum_x1(k, l) = sum_x1(k,l) + P_x2x1y_xy{j}(k, l);
                end
            end
        end
        sum_x2(j) = sum(sum(P_x2x1y_xy{j}));
    end
    for j = 1:20
        for k = 1:size(I,1)
            for l = 1:size(I,2)
                if (sum_x1(k,l) ~= 0)
                    P_x2x1y_xy{j}(k,l) = P_x2x1y_xy{j}(k,l) / sum_x1(k,l);
                end
            end
        end
    end
    %% Maximization
    count_x2 = zeros(size(P_x2));
    count_x1 = zeros(size(P_x1));
    for j = 1 : size(I,1) %288
        for k = 1 : size(I,2) %531
            for l = 1 : 20
                if (l <= k)
                    this_count = double(I(j,k)) * P_x2x1y_xy{l}(j,k);
                    count_x2(l) = this_count + count_x2(l);
                    count_x1(j,k-(l-1)) = this_count + count_x1(j,k-l+1);
                end
            end
        end
    end
    P_x1 = double(count_x1) / sum(sum(count_x1));
    P_x2 = double(count_x2) / sum(count_x2);
    disp(['iteration ', num2str(i), ', difference:', num2str(norm(P_x1-P_x1_old))]);
end
end