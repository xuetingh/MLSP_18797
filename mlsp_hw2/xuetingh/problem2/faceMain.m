train_fcs = load('problem2/train_faces.mat');
trainfcs = train_fcs.trainfcs;
test_fcs1 = load('problem2/test_faces.mat');
testfcsorg = test_fcs1.testfcsorg;
test_fcs = load('problem2/test_faces_cor.mat');
testfcs = test_fcs.testfcs; % or test_faces_cor.mat

niter = 500;
K = [100, 200, 300, 400, 500];
error = [];
error_cor = [];
for i = 1:5
    B_init = load(['problem2/B',num2str(K(i)),'.mat']);
    Binit = B_init.B;
    W_init = load(['problem2/W',num2str(K(i)),'.mat']);
    Winit = W_init.W;
    W_testinit = load(['problem2/Wtest',num2str(K(i)),'.mat']);
    Wtest = W_testinit.Wtest;
    % ADD CODE TO COMPUTE MEAN RECONSTRUCTION ERROR FOR TEST FACES
    B = doNMF(trainfcs,K(i),niter,Binit,Winit);
    recon_faces = NMFreco(testfcsorg,B,niter,Wtest);
    recon_faces2 = NMFreco(testfcs,B,niter,Wtest);
    
    % select a randomly selected face, plot:
    % 1)this face; 2)its reconstruction; 3) this face corrupted; 4)
    % reconstructed corrupted face
    %feel free to modify it to show multiple faces and their reconstruction
    isel = randi(size(testfcs,2));
    figure
    subplot(2,2,1);
    imshow(reshape(testfcsorg(:,isel),32,32));
    subplot(2,2,2);
    imshow(reshape(recon_faces(:,isel),32,32));
    subplot(2,2,3);
    imshow(reshape(testfcs(:,isel),32,32));
    subplot(2,2,4);
    imshow(reshape(recon_faces2(:,isel),32,32));
    saveas(gcf,['results/K_' num2str(K(i)) '.png']);
    e = calculate_error(recon_faces, testfcsorg);
    e_c = calculate_error(recon_faces2, testfcsorg);
    error = [error,e];
    error_cor = [error_cor, e_c];
end
