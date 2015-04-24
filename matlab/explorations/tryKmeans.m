function labels = tryKmeans(segments, I, K)

% Extract pixel values
pixels = valuesPerLabel(I, segments);

% Create feature vector
featureVect = getColorFeatures(pixels);

% Kmeans
pxLabels = kmeans(featureVect, K, 'distance', 'cityblock');

labels = relabelImg(I, pixels, pxLabels);

end

function features = getFeatures(values, binSz)

    features = [];
    for ch = 1:size(values,3)
        chVals = values(:,:,ch);
        features = [features, hist(chVals(:), binSz)];
    end
end