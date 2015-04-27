%% Try test img

clear all
close all

%% Load

trainI = im2double(imread('../../data/example1.png'));
r = load('../../data/example1Labels.mat');
trainGt = r.imIndx;
mapping = r.mapping;

testI = im2double(imread('../../data/example2.png'));
r = load('../../data/example2Labels.mat');
testGt = r.imIndx;

figure; 
subplot(2,2,1); imshow(trainI);
subplot(2,2,2); imshow(trainGt / max(trainGt(:)));
subplot(2,2,3); imshow(testI);
subplot(2,2,4); imshow(testGt / max(testGt(:)));

overlay = zeros(size(trainI));
overlay(:,:,1) = rgb2gray(trainI); overlay(:,:,3) = .5*trainGt/max(trainGt(:));
figure; subplot(2,1,1); imshow(overlay);

overlay = zeros(size(testI));
overlay(:,:,1) = rgb2gray(testI); overlay(:,:,3) = .5*testGt/max(testGt(:));
subplot(2,1,2); imshow(overlay);

%% SLIC

regionSz = 50;
regulizer = .1;
segments = trySlic(I, regionSz, regulizer, true);
segI = vizSlic(segments, I, regionSz, regulizer);

%% Kmeans

K = length(unique(gtI));

kmeansLabels = tryKmeans(segments, labI, K);
figure; imshow(kmeansLabels/K);

%% Accuracy

relabled = relabelImgGt(kmeansLabels, gtI);

figure; imshow(relabled/K);

[C, acc] = scoreResult(relabled, gtI, length(mapping))
