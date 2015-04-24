function registered = registerImgs(target, unregistered)

sz = size(target);
box = .5*ones(sz(1:2));

[movingPoints, fixedPoints] = cpselect(unregistered, target, 'Wait', true)
mytform = fitgeotrans(movingPoints, fixedPoints, 'projective');

registered = imwarp(unregistered, mytform, 'nearest');
mask = imwarp(box, mytform, 'nearest');
figure; imshow(registered);
figure; imshow(mask);
imwrite(registered, 'registered.png', 'png');

end