% converts frequency in hertzs to pitch in mels (which has some
% relation to human perception of sound)
function y = hz2mel(x)
    %y = 1000/log10(2)*log10(1+x/1000);
    y = (1000/log(1+10/7))*log(1+x/700);
end
