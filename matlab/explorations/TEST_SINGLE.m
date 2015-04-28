%% Try test img

clear all
close all

%% Load

I = im2double(imread('../../data/example1.png'));
r = load('../../data/example1Labels.mat');
gtI = r.imIndx;
mapping = r.mapping;

g1 = rgb2gray(I);
g2 = gtI / max(gtI(:));

labI = RGB2Lab(I);

figure; 
subplot(2,1,1); imshow(I);
subplot(2,1,2); imshow(g2);

overlay = zeros(size(I));
overlay(:,:,1) = g1; overlay(:,:,3) = .5*g2;
figure; imshow(overlay);

%% SLIC

regionSz = 50;
regulizer = .1;
segments = trySlic(RGB2Lab(I), regionSz, regulizer, true);
segI = vizSlic(segments, I, regionSz, regulizer);

%% Kmeans

K = length(unique(gtI));

kmeansLabels = tryKmeans(segments, I, K);
figure; imshow(kmeansLabels/K);

%% Accuracy

relabled = relabelImgGt(kmeansLabels, gtI);

figure; imshow(relabled/K);

[C, acc] = scoreResult(relabled, gtI, length(mapping))
