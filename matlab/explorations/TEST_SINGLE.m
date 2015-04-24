%% Try test img

clear all
close all

%% Load

I = im2double(imread('../../data/livingstonIL/example.png'));

figure; imshow(I);

labI = RGB2Lab(I);
figure;
subplot(3,1,1); imagesc(labI(:,:,1));
subplot(3,1,2); imagesc(labI(:,:,2));
subplot(3,1,3); imagesc(labI(:,:,3));

%% SLIC

regionSz = 50;
regulizer = .1;
segments = trySlic(I, regionSz, regulizer, true);
segI = vizSlic(segments, I, regionSz, regulizer);
%imwrite(segI, '../../data/livingstonIL/slic2.jpg');

%% Kmeans

K = 5;
kmeansLabels = tryKmeans(segments, I, K);
figure; imshow(kmeansLabels/K);
