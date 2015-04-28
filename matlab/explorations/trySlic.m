function segments = trySlic(I, regionSz, regulizer, verbose, lab)

%% Install lib
run '../libraries/vlfeat-0.9.20/toolbox/vl_setup'

%% Convert to LAB space
if lab
    colorTransform = makecform('srgb2lab');
    labI = applycform(I, colorTransform);
else
    labI = I;
end

%% Convert to single precision
singleI = single(labI);

%% Run SLIC
if verbose
    segments = vl_slic(singleI, regionSz, regulizer, 'verbose');
else
    segments = vl_slic(singleI, regionSz, regulizer);
end

end