%% Try test img

clear all
close all

%% Load

trainI = im2double(imread('../../data/example1.png'));
r = load('../../data/example1Labels.mat');
trainGt = r.imIndx;
trainWordMap = 
mapping = r.mapping;

testI = im2double(imread('../../data/example2.png'));
r = load('../../data/example2Labels.mat');
testGt = r.imIndx;
testWordMap = 

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
rgbPixels = valuesPerLabel(trainI, trainSeg);
labPixels = valuesPerLabel(RGB2Lab(trainI), trainSeg);
featureVect1 = getColorFeatures(rgbPixels);
featureVect2 = getColorFeatures(labPixels);
featureVect3 = getWaveletFeatures(trainI, rgbPixels);
featureVect = [featureVect1, featureVect2, featureVect3];
pxLabels = getPixelLabels(trainGt, rgbPixels);

vizLabels = relabelImg(trainI, rgbPixels, pxLabels);
figure; 
subplot(2,1,1); imshow(trainGt / max(trainGt(:)));
subplot(2,1,2); imshow(vizLabels / max(vizLabels(:)));

%% Model
mdl = fitcknn(featureVect, pxLabels, 'distance', 'cityblock', 'NumNeighbors', 5);
%net = patternnet(10);
%x = featureVect';
%relabel = pxLabels;
%relabel((relabel ~= 1) & (relabel ~= 2)) = 3;
%n = max(relabel);
%N = length(relabel);
%t = sparse(relabel,1:N,1,n,N);
%t = full(M);
%net = train(net,x,t);
%nntraintool

%% Testing

testSeg = trySlic(testI, regionSz, regulizer, true, true);
segI = vizSlic(testSeg, testI, regionSz, regulizer);

rgbPixels = valuesPerLabel(testI, testSeg);
labPixels = valuesPerLabel(RGB2Lab(testI), testSeg);
featureVect1 = getColorFeatures(rgbPixels);
featureVect2 = getColorFeatures(labPixels);
featureVect3 = getWaveletFeatures(testI, rgbPixels);
featureVect = [featureVect1, featureVect2, featureVect3];

pxLabels = predict(mdl, featureVect);
%y = net(featureVect');
%pxLabels = vec2ind(y);
knnLabels = relabelImg(testI, rgbPixels, pxLabels);

%% Accuracy

figure; 
subplot(2,1,1); imshow(testGt / max(testGt(:)));
subplot(2,1,2); imshow(knnLabels / max(knnLabels(:)));


[C, acc] = scoreResult(knnLabels, testGt, length(mapping))
