function pxLabels = getPixelLabels(labels, pixels)

numPx = length(pixels);
pxLabels = zeros(numPx,1);
for p = 1:numPx
   pxLabels(p) = mode(labels(pixels(p).mask));    
end

end