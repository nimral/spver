% compute log mel-frequncy bands for whole wav file
function y = mfcc(filename)

    %filename = '3_cuave09_019.wav';
    snd = wavread(filename);

    % Pre-emphasis is done in order to emphasize higher frequencies.
    sound = preemphasis(snd);

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

        % Maybe we should consider doing onw more step here
        % (suggested in a paper on feature extraction):
        % Usually the frame is multiplied by a smooth window
        % function (e.g. Hamming) prior to further steps (fft). 
        % A smooth windowing function is applied because of
        % the problems fft has with finite length vectors.
        wdw = transpose(hamming(length(window))).*window;

        y = fft(wdw);
        
        % window is a real vector, we are interested only in the first half of fft
        y = y(1:length(y) / 2);

        % y is complex, we want the energies of individual frequencies
        y = abs(y);


        for i = 1:nbands
            
            % centre of the filter
            centre = d * i;

            % add its amplitude filtered by a triangular filter centered at
            % centre to the corresponding band
            bands(w, i) = bands(w, i) + filterweight(centre, d, mel_centres) * y';
        end
    end

    % not sure why
    bands = log(bands);
    % bar(bands(1, :))

    % apply DCT on the individual bands to get the cepstral coefficients
    coef = dct(bands')';

    % take only a few first coefficients (12-15 is recommended)
    M = 11;
    coef = coef(:, 1:M);

	% Coefficient Liftering.
	% The higher order cepstral coefficients tend to be numerically small compared
	% to the lower order c.c. The following code rescales the coefficients.
	% Found at: http://research.ijcaonline.org/volume40/number3/pxc3877167.pdf
	% Anyone with some Matlab skills please optimize the code.
	[rows,cols] = size(coef);
	for i = 1:rows
		for j = 1:cols
			coef(i,j) = (1 + (M / 2) * sin((pi * j) / M)) * coef(i,j);
		end
	end

    % Add delta and delta-delta cepstra to the final vectors
    delta1 = [zeros(1, M) ; coef(2:end, :) - coef(1:end-1, :)];
    delta2 = [zeros(1, M) ; delta1(2:end, :) - delta1(1:end-1, :)];

    y = [coef delta1 delta2];
end
