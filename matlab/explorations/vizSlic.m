function [segI, imp] = vizSlic(segments, I, regionSz, regulizer)

% overaly segmentation
[sx,sy]=vl_grad(double(segments), 'type', 'forward') ;
s = find(sx | sy) ;
imp = I ;
imp([s s+numel(I(:,:,1)) s+2*numel(I(:,:,1))]) = 0 ;
figure; imshow(imp); title(['RegionSz: ', num2str(regionSz), ...
    ' Regulizer: ', num2str(regulizer)]); 

% Take average in each region
labels = unique(segments);
segI = I;
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
N = numel(R);
for l = labels'
    indx = find(segments == l);
    segI(indx) = median(R(indx));
    segI(indx+N) = median(G(indx));
    segI(indx+2*N) = median(B(indx));
end

figure; imshow(segI); title(['RegionSz: ', num2str(regionSz), ...
    ' Regulizer: ', num2str(regulizer)]); 

end
