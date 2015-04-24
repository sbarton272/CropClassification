function segI = vizSlic(segments, I, regionSz, regulizer)

% overaly segmentation
[sx,sy]=vl_grad(double(segments), 'type', 'forward') ;
s = find(sx | sy) ;
imp = I ;
imp([s s+numel(I(:,:,1)) s+2*numel(I(:,:,1))]) = 0 ;
figure; imshow(imp); title(['RegionSz: ', num2str(regionSz), ...
    ' Regulizer: ', num2str(regulizer)]); 
imwrite(imp, '../../data/livingstonIL/slic1.jpg');

% Take average in each region
labels = unique(segments);
segI = I;
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
N = numel(R);
for l = labels'
    indx = find(segments == l);
    segI(indx) = mean(R(indx));
    segI(indx+N) = mean(G(indx));
    segI(indx+2*N) = mean(B(indx));
end

figure; imshow(segI); title(['RegionSz: ', num2str(regionSz), ...
    ' Regulizer: ', num2str(regulizer)]); 

end