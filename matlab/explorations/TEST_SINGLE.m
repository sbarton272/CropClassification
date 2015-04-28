%% Try test img

clear all
close all

%% Load

r = load('../../data/example1Labels.mat');
mapping = r.mapping;

data = load('../../data/labeledData.mat');
data = data.labeledData;

I = data(1).image;
gtI = data(1).gt;
wordmapI = data(1).wordmap;

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
segments = trySlic(I, regionSz, regulizer, true, true);
segI = vizSlic(segments, I, regionSz, regulizer);

%% Kmeans

K = length(unique(gtI));

kmeansLabels = tryKmeans(segments, wordmapI, K);
figure; imshow(kmeansLabels/K);

%% Accuracy

relabled = relabelImgGt(kmeansLabels, gtI);

figure; imshow(relabled/K);

[C, acc] = scoreResult(relabled, gtI, length(mapping))
