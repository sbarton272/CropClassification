function waveFeatures = getWaveletFeatures(I, pixels)

N = 3;
ORD = 4;
BIN_SZ = 256;
FLT = 'haar';
wpt = wpdec2(I,N,FLT);
wt = wp2wtree(wpt);

leafNodes = leaves(wt);
numLeafNodes = length(leafNodes);
waveFeatures = zeros(length(pixels), BIN_SZ*numLeafNodes);
for i = 1:numLeafNodes
    leaf = leafNodes(i);
    [D, P] = ind2depo(ORD, leaf);
    im = wprcoef(wt, [D P]);
    start = BIN_SZ*(i-1)+1;
    for p = 1:length(pixels)
        values = im(pixels(p).mask);
        waveFeatures(p, start:start+BIN_SZ-1) = hist(values, BIN_SZ);
    end
end

end