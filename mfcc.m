x = wavread('3_cuave09_019.wav');

% split into windows of 20 ms each
% f = 16000 Hz
% 1000 ms ~ 16000 samples
% 20 ms ~ 320 samples
window = x(1+2200:320+2200);

y = fft(window);
% window is real vector, we are interested only in the first half
y = y(1:length(y)/2);

% y is complex, we want the energies of individual frequencies
y = abs(y);

% 160 bins ~ 8000 Hz
% 1 bin ~ 50 Hz
% plot((1:320/2) * 50, y)
binsize = 50;


% 24 filter banks, equidistant in the mel-frequency scale
% distance 110 Mel
d = 110;
nbands = floor(hz2mel(8000) / d) - 1;

bands = zeros(1, nbands);
% i-th mel-frequency band
for i = 1:nbands
    centre = d * i;
    % filter weight is 1 at centre, 0 at centre +- d, triangular
    % shape
    % what is the weight of the filter at frequency x?
    for j = 1:length(y)
        x = hz2mel(binsize/2 + (j-1) * binsize);

        weight = 0;
        if x < centre && x > centre - d
            weight = (x - (centre - d)) / d;
        elseif x >= centre && x < centre + d
            weight = ((centre + d) - x) / d;
        end

        bands(i) += weight * y(j);
    end
end
    
bands = log(bands);
    

