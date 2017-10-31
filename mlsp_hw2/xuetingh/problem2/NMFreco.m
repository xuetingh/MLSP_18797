function recon_faces = NMFreco(testfcs,B,niter,Winit)
for i = 1:niter
    Winit = Winit .* (B' * testfcs) ./ (B' * (B * Winit));
end
recon_faces = B * Winit;
end