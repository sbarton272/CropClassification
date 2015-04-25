function [C, acc] = scoreResult(labledI, gtI, numGt)

C = zeros(numGt);

for gt = 1:numGt
    matchingLabels = labledI(gtI == gt);
    for guess = 1:numGt
        C(gt,guess) = sum(matchingLabels == guess);
    end
end

acc = sum(diag(C)) / sum(C(:));

end