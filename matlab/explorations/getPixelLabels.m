function [pxLabels, pixels] = getPixelLabels(labels, pixels)

numPx = length(pixels);
pxLabels = zeros(numPx,1);
for p = 1:numPx
   lbls = labels(pixels(p).mask);
   pxLabels(p) = mode(lbls);
   acc = sum(lbls == pxLabels(p)) / numel(lbls);
   if acc < .9
       pxLabels(p) = 0;
   end
end

pixels(pxLabels == 0) = [];
pxLabels(pxLabels == 0) = [];

end