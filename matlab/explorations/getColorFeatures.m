function featureVect = getColorFeatures(pixels)

BIN_SIZE = 256;
numChannels = size(pixels(1).values,3);
numPixels = length(pixels);
featureVect = zeros(numPixels, BIN_SIZE*numChannels); 
for i = 1:numPixels
   pixel = pixels(i);
   featureVect(i,:) = getFeatures(pixel.values, BIN_SIZE);
end

end

function features = getFeatures(values, binSz)

    features = [];
    for ch = 1:size(values,3)
        chVals = values(:,:,ch);
        features = [features, hist(chVals(:), binSz)];
    end
end