%% Try test img

clear all
close all

%% Load

data = load('../../data/labeledData.mat');
data = data.labeledData;

trainI = data(1).image;
trainGt = data(1).gt;
trainWordMap = data(1).wordmap;

r = load('../../data/example1Labels.mat');
mapping = r.mapping;

testI = data(2).image;
testGt = data(2).gt;
testWordMap = data(2).wordmap;

%figure; 
%subplot(2,2,1); imshow(trainI);
%subplot(2,2,2); imshow(trainGt / max(trainGt(:)));
%subplot(2,2,3); imshow(testI);
%subplot(2,2,4); imshow(testGt / max(testGt(:)));

% overlay = zeros(size(trainI));
% overlay(:,:,1) = rgb2gray(trainI); overlay(:,:,3) = .5*trainGt/max(trainGt(:));
% figure; subplot(2,1,1); imshow(overlay);
% 
% overlay = zeros(size(testI));
% overlay(:,:,1) = rgb2gray(testI); overlay(:,:,3) = .5*testGt/max(testGt(:));
% subplot(2,1,2); imshow(overlay);

%% Consts
regionSz = 50;
regulizer = .1;

%% Training

% SLIC on labels to get regions
trainSeg = trySlic(trainGt, 25, 2, true, false);
%segI = vizSlic(trainSeg, trainI, regionSz, regulizer);

% Features
rgbPixels = valuesPerLabel(trainWordMap, trainSeg);
[pxLabels, goodPixels] = getPixelLabels(trainGt, rgbPixels);
featureVect = getColorFeatures(goodPixels);

vizLabels = relabelImg(trainI, goodPixels, pxLabels);
figure; 
subplot(2,1,1); imshow(trainGt / max(trainGt(:)));
subplot(2,1,2); imshow(vizLabels / max(vizLabels(:)));

%% Model
mdl = fitcknn(featureVect, pxLabels, 'distance', 'euclidean', 'NumNeighbors', 5);

%% Testing

testSeg = trySlic(testI, regionSz, regulizer, true, true);
segI = vizSlic(testSeg, testI, regionSz, regulizer);

rgbPixels = valuesPerLabel(testWordMap, testSeg);
featureVect = getColorFeatures(rgbPixels);

pxLabels = predict(mdl, featureVect);
knnLabels = relabelImg(testI, rgbPixels, pxLabels);

%% Accuracy

figure; 
subplot(2,1,1); imshow(testGt / max(testGt(:)));
subplot(2,1,2); imshow(knnLabels / max(knnLabels(:)));

[C, acc] = scoreResult(knnLabels, testGt, length(mapping))
