function relabled = relabelImgGt(labelI, gtI)

labels = unique(labelI(:));
gtLabels = unique(gtI(:));

if length(labels) ~= length(gtLabels)
    disp('Error in relabelImgGt');
    return
end

relabled = zeros(size(labelI));
for label = labels'
    matchingGt = gtI(labelI == label);
    mostCommonGt = mode(matchingGt);
    relabled(labelI == label) = mostCommonGt;
end

end