%% Lab 2: 2D Convolution & FIR Filters (Blur, Sharpen, Edges)
% Course: Mathematical Algorithms (DSP) — Image Processing Labs
% HOW TO SUBMIT: include screenshots or saved figures + short notes in GitHub
% -------------------------------------------------------------------------
close all; clear; clc;

outdir = 'figures';
if ~exist(outdir, 'dir')
    mkdir(outdir);
end

% Load demo image
if exist('peppers.png','file')
    I0 = imread('peppers.png');
else
    I0 = repmat(imread('cameraman.tif'),1,1,3);
end
I = im2double(rgb2gray(I0));

%% 1) Delta image & impulse response
delta = zeros(101,101); delta(51,51) = 1;
h_avg = ones(3,3)/9;
H_vis = conv2(delta, h_avg, 'same');

f1 = figure; imagesc(H_vis); axis image off; colorbar;
title('Impulse response of 3x3 average');
saveas(f1, fullfile(outdir, 'impulse_response.png'));

%% 2) Low-pass: box vs Gaussian
h_box3 = ones(3,3)/9;
h_box7 = ones(7,7)/49;
sigma = 1.2;
g1d = fspecial('gaussian',[1 7], sigma);
h_gauss = g1d' * g1d;

I_box3 = imfilter(I, h_box3, 'replicate');
I_box7 = imfilter(I, h_box7, 'replicate');
I_gauss = imfilter(I, h_gauss, 'replicate');

f2 = figure;
montage({I, I_box3, I_box7, I_gauss}, 'Size', [1 4]);
title('Original | Box 3x3 | Box 7x7 | Gaussian (separable)');
saveas(f2, fullfile(outdir, 'lowpass_box_vs_gaussian.png'));

%% 3) Unsharp masking
I_blur = imfilter(I, h_gauss, 'replicate');
mask = I - I_blur;
gain = 1.0;
I_sharp = max(min(I + gain*mask, 1), 0);

f3 = figure;
montage({I, I_blur, mat2gray(mask), I_sharp}, 'Size', [1 4]);
title('Original | Blur | High-freq mask | Sharpened');
saveas(f3, fullfile(outdir, 'unsharp_masking.png'));

%% 4) Edge detection
h_sobel_x = fspecial('sobel');
h_sobel_y = h_sobel_x';
Gx = imfilter(I, h_sobel_x, 'replicate');
Gy = imfilter(I, h_sobel_y, 'replicate');
Gmag = hypot(Gx, Gy);
h_lap = fspecial('laplacian', 0.2);
I_lap = imfilter(I, h_lap, 'replicate');

f4 = figure;
montage({mat2gray(Gx), mat2gray(Gy), mat2gray(Gmag), mat2gray(I_lap)}, 'Size', [1 4]);
title('Sobel Gx | Sobel Gy | Gradient magnitude | Laplacian');
saveas(f4, fullfile(outdir, 'edges_sobel_laplacian.png'));

%% 5) Correlation vs convolution
C_conv2 = conv2(I, h_box3, 'same');
C_imf_c = imfilter(I, h_box3, 'conv', 'same');
C_imf_r = imfilter(I, h_box3, 'same');
diff_conv_vs_conv = max(abs(C_conv2(:) - C_imf_c(:)));
diff_conv_vs_corr = max(abs(C_conv2(:) - C_imf_r(:)));
fprintf('Max diff (conv2 vs imfilter with ''conv''): %g\n', diff_conv_vs_conv);
fprintf('Max diff (conv2 vs imfilter default corr): %g\n', diff_conv_vs_corr);

%% 6) Boundary handling
I_rep = imfilter(I, h_box7, 'replicate');
I_sym = imfilter(I, h_box7, 'symmetric');
I_cir = imfilter(I, h_box7, 'circular');

f5 = figure;
montage({I_rep, I_sym, I_cir}, 'Size', [1 3]);
title('Boundary: replicate | symmetric | circular');
saveas(f5, fullfile(outdir, 'boundary_modes.png'));
