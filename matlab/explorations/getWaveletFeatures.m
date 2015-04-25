function waveFeatures = getWaveletFeatures(I)

waveFeatures = 

N = 3;
[C,S] = wavedec2(I,N,'haar');



end