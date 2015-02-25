% Pre-emphasize the sound signal:
% sound_new(n) = sound_old(n) - c*sound_old(n-1),
% where c is some constant which can be tuned
% and sound_old(0) = 0.
function y = preemphasis(x)
    c = 0.4;
    b = [1, -c];
    a = 1;
    y = filter(b,a,x);
end
