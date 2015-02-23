% converts frequency from hertz to mel-scale
function y = hz2mel(x)
    %y = 1000/log10(2)*log10(1+x/1000);
    y = (1000/log(1+10/7))*log(1+x/700);
end
