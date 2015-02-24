% converts pitch in mels to frequency in hertzs
function y = mel2hz(x)
    c = log(1 + 10/7) / 1000;
    y = 700 * (e**(x*c) - 1);
end
