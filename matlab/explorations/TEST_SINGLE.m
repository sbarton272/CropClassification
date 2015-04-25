%% Try test img

clear all
close all

%% Load

% TODO
% - Allign
% - Fix labels
% - 

I = im2double(imread('../../data/livingstonIL/example.png'));
labelI = im2double(imread('../../data/livingstonIL/exampleLabels.tif'));

figure; 
subplot(2,1,1); imshow(I);
subplot(2,1,2); imshow(labelI);

g1 = rgb2gray(I);
g2 = rgb2gray(labelI);
overlay = zeros(size(I));
overlay(:,:,1) = g1; overlay(:,:,3) = .5*g2;
figure; imshow(overlay);

%labI = RGB2Lab(I);
%figure;
%subplot(3,1,1); imagesc(labI(:,:,1));
%subplot(3,1,2); imagesc(labI(:,:,2));
%subplot(3,1,3); imagesc(labI(:,:,3));

%% SLIC

regionSz = 50;
regulizer = .1;
segments = trySlic(I, regionSz, regulizer, true);
segI = vizSlic(segments, I, regionSz, regulizer);
%imwrite(segI, '../../data/livingstonIL/slic2.jpg');

%% Kmeans

K = 8;
kmeansLabels = tryKmeans(segments, I, K);
figure; imshow(kmeansLabels/K);
