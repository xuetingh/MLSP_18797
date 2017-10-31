function B = doNMF(trainfcs,K,niter,Binit,Winit)
for i = 1:niter
    Binit = Binit .* (trainfcs * Winit') ./ ((Binit * Winit) * Winit');
    Winit = Winit .* (Binit' * trainfcs) ./ (Binit' * (Binit * Winit));
end
B = Binit(:, 1:K);
end