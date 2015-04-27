function correctLabels(labelName)

% TODO decimation step

possibleLabels = [255, 212, 0; ...
    38, 115, 0; ...
    233, 255, 190; ...
    149, 206, 147; ...
    156, 156, 156; ...
    77, 112, 163; ...
    255, 168, 227; ...
    168, 112, 0];
possibleLabels = possibleLabels / 255;

mapping = {'corn', 'soybeans', 'grass', 'forest', ...
    'developed', 'water', 'alfalpha', 'winter wheat'};

labelIm = im2double(imread(labelName));

regionSz = 25;
regulizer = 2;
segments = trySlic(labelIm, regionSz, regulizer, true);
[segI, segI2] = vizSlic(segments, labelIm, regionSz, regulizer);

% knnsearch
rgb = toRgb(segI);
indx = knnsearch(possibleLabels, rgb, 'dist', 'cityblock');
im = possibleLabels(indx, :);
sz = size(segI);
im = fromRgb(im, sz);

figure; subplot(2,2,1); imshow(labelIm);
subplot(2,2,3); imshow(segI);
subplot(2,2,4); imshow(segI2);
subplot(2,2,2); imshow(im);

imIndx = reshape(indx, sz(1:2));

imwrite(im, 'corrected.png', 'png');

figure; imshow(imIndx / max(imIndx(:)));
save('simpleLabels.mat', 'imIndx', 'mapping');

end

function rgb = toRgb(im)
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
rgb = [r(:), g(:), b(:)];
end

function im = fromRgb(rgb, sz)
r = reshape(rgb(:,1), sz(1:2));
g = reshape(rgb(:,2), sz(1:2));
b = reshape(rgb(:,3), sz(1:2));
im = cat(3, r, g, b);
end
