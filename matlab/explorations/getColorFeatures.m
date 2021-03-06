function featureVect = getColorFeatures(pixels)

BIN_SIZE = 256;
numChannels = size(pixels(1).values,2);
numPixels = length(pixels);
featureVect = zeros(numPixels, BIN_SIZE*numChannels); 
for i = 1:numPixels
   pixel = pixels(i);
   featureVect(i,:) = getFeatures(pixel.values, BIN_SIZE);
end

end

function features = getFeatures(values, binSz)

    features = [];
    for ch = 1:size(values,2)
        chVals = values(:,ch);
        h = hist(chVals, binSz);
        h = h / sum(h);
        features = [features, h];
    end
    features = features';
end