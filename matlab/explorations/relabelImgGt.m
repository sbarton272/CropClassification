function relabled = relabelImgGt(labelI, gtI)

labels = unique(labelI(:));
gtLabels = unique(gtI(:));

if length(labels) ~= length(gtLabels)
    disp('Error in relabelImgGt');
    return
end

relabled = zeros(size(labelI));
% Relabel by largest to smallest
cnts = hist(labelI(:), labels);
[~, sortIndx] = sort(cnts, 'descend');

matched = ones(1,length(gtLabels));
for i = sortIndx
    label = labels(i);
    matchingGt = gtI(labelI == label);

    % Match with most common non-matched gtLabel
    [cnts, ~] = hist(matchingGt, gtLabels);
    cnts = cnts.*matched;
    [~, sortIndx] = sort(cnts, 'descend');
    mostCommonGt = gtLabels(sortIndx(1));
    matched(sortIndx(1)) = 0;
    
    relabled(labelI == label) = mostCommonGt;
end

end