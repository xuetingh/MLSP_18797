clear
%% Load images
% For women and men
%% Compute First eigen face for each group
% size of row and column
[T_norm, V] = load_data('problem1/training/men/');
[T2_norm, V2] = load_data('problem1/training/women/');
%% Compute First eigen face for each group
% see Matlab Instructions
%error_test_eigenface
e_m_m = calculate_error(T, V(:,1));
e_m_w = calculate_error(T, V2(:,1));
e_w_m = calculate_error(T2, V(:,1));
e_w_w = calculate_error(T2, V2(:,1));

%% Save results
% Save plot of both eigen faces
colormap gray
saveas(imagesc(reshape(V(:,1),r,c)),'results/EigenFace_men.jpg');
saveas(imagesc(reshape(V2(:,1),r,c)),'results/EigenFace_women.jpg');


