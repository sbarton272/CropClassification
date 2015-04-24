function [label_struct] = valuesPerLabel(values, labels)
    
    if ~all([size(values,1),size(values,2)]  == [size(labels,1),size(labels,2)])
        error('values and labels should be same size');
    end
    
    unique_labels = sort(unique(labels(:)));
    
    num_channels = size(values, 3);
    
    num_labels = numel(unique_labels);  
    label_struct = struct('label', [], 'mask', [], 'values', [], 'centroid', []);
    for m = 1:num_labels
        lab = uint32(unique_labels(m));
        mask = labels == lab;
        num_in_mask = nnz(mask);
        val = zeros(num_in_mask,num_channels);
        for n = 1:num_channels
            dim_val = values(:,:,n);
            val(:,n) = dim_val(mask);
        end

        label_struct(m).label = lab;
        label_struct(m).mask = mask;
        label_struct(m).values = val;
        
        [r,c] = find(mask);
        label_struct(m).centroid = [mean(r), mean(c)];
    end
end