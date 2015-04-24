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