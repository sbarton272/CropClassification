function labels = tryKmeans(segments, I, K)

% Extract pixel values
pixels = valuesPerLabel(I, segments);

% Create feature vector
BIN_SIZE = 256;
numChannels = size(pixels(1).values,3);
numPixels = length(pixels);
featureVect = zeros(numPixels, BIN_SIZE*numChannels); 
for i = 1:numPixels
   pixel = pixels(i);
   featureVect(i,:) = getFeatures(pixel.values, BIN_SIZE);
end

% Kmeans
pxLables = kmeans(featureVect, K, 'distance', 'cityblock');

% Relabel image
labels = zeros(size(I,1),size(I,2));
for i = 1:numPixels
   pixel = pixels(i);
   labels = labels + pixel.mask * pxLables(i);
end

end

function features = getFeatures(values, binSz)

    features = [];
    for ch = 1:size(values,3)
        chVals = values(:,:,ch);
        features = [features, hist(chVals(:), binSz)];
    end
end