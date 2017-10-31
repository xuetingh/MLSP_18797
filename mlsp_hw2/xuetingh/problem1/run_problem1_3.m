clear
%% Load images
[T1_norm, V] = load_data('problem1/training/men/');
[T2_norm, V2] = load_data('problem1/training/women/');
[T3_norm, ] = load_data('problem1/testing/men/');
[T4_norm, ] = load_data('problem1/testing/women/');
%% Compute K eigen faces for each group using Training Set
%% Define Features for Training and Testing
[bases,X_tr,Y_tr, X_te, Y_te] = get_bases(V,V2,150,T1_norm, T2_norm,T3_norm, T4_norm);
%% Save results
% Save plot of both eigen faces
% saved in problem 1_1
%% Repeat with different values of K
K = [10,50,100,150,200];
err_tr = zeros(1,5);
err_te = zeros(1,5);
accuracy_tr = zeros(1,5);
accuracy_te = zeros(1,5);
T = [10,50,100,150,200];
for a = 1:5
    [bases,X_tr,Y_tr, X_te, Y_te] = get_bases(V,V2,K(a),T1_norm, T2_norm,T3_norm, T4_norm);
    for b = 1:5
        Y_pred_test=adaboost(X_tr, Y_tr, T(b), X_te);
        Y_pred_train=adaboost(X_tr, Y_tr, T(b), X_tr);
        for c = 1:400
            if Y_pred_test(c) ~= Y_te(c)
                err_te(b) = err_te(b) + 1;
            end
        end
        err_te(b) = err_te(b) / 400.0;
        accuracy_te(b) = 1 - err_te(b);
        for d = 1:5000
            if Y_pred_train(d) ~= Y_tr(d)
                err_tr(b) = err_tr(b) + 1;
            end
        end
        err_tr(b) = err_tr(b) / 5000.0;
        accuracy_tr(b) = 1 - err_tr(b);

    end
    figure
    plot(T, accuracy_tr,'r',T,accuracy_te,'g');
    saveas(gcf,['results/problem13_K_' num2str(K(a)) 'accuracy.png']);
end
