numrows = 9;
numcols = 9;

images = cell(1, numrows*numcols);
h = 1;
for row=1:numrows
    for col=1:numcols
        filename = sprintf('row%icol%i.png',row, col);
        [im, map] = imread(filename);
        images{h} = im;
        h=h+1;
    end
end

save('testdata.mat', 'images');