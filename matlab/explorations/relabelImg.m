function labels = relabelImg(I, pixels, pxLabels)

% Relabel image
labels = zeros(size(I,1),size(I,2));
numPixels = length(pixels);
for i = 1:numPixels
   pixel = pixels(i);
   labels = labels + pixel.mask * pxLabels(i);
end

end