% converts sound vector to vector of overlaping time windows
% x -- sound vector
% wintime -- duration of the window in ms
% steptime -- time difference between consecutive windows starts, in ms
% samplerate -- samplerate of the sound
function y = sound2windows(x, wintime, steptime, samplerate)

    winsize = (wintime / 1000) * samplerate;
    step = (steptime / 1000) * samplerate;

    % number of time windows
    nwindows = floor((length(x) - winsize) / step);

    % result
    y = zeros(nwindows, winsize);

    for i = 1:nwindows
        start = (i-1) * step + 1;
        y(i, :) = x(start:start + winsize - 1);
    end
end
