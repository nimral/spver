% compute log mel-frequncy bands for whole wav file

filename = '3_cuave09_019.wav';
sound = wavread(filename);

% split into windows of 20 ms each, 10 ms overlap
% fs = 16000 Hz
% 1000 ms ~ 16000 samples
% 20 ms ~ 320 samples
windows = sound2windows(sound, 20, 10, 16000);

% after fft:
% 320/2 = 160 bins ~ 8000 Hz (half of the samplerate)
% 1 bin ~ 50 Hz
binsize = 50;

% 24 filter banks, equidistant in the mel-frequency scale
% distance 110 Mel
d = 110;

% number of bands
nbands = floor(hz2mel(8000) / d) - 1;

% matrix, in each row will be the mel-frequency bands for one time window
bands = zeros(size(windows, 1), nbands);

% compute the pitch of centres of frequency bands
mel_centres = hz2mel(binsize/2 + ((1:160)-1) * binsize);

for w = 1:size(windows, 1)
    window = windows(w, :);

    y = fft(window);
    
    % window is a real vector, we are interested only in the first half of fft
    y = y(1:length(y) / 2);

    % y is complex, we want the energies of individual frequencies
    y = abs(y);


    for i = 1:nbands
        
        % centre of the filter
        centre = d * i;

        % add its amplitude filtered by a triangular filter centered at
        % centre to the corresponding band
        bands(w, i) += filterweight(centre, d, mel_centres) * y';
    end
end

% not sure why
bands = log(bands);

%bar(bands(1, :))
