% The shortest distance from a to some digit in digits
function y = min_distance(a, digits)
    m = Inf;
    for i = 1:length(digits)
        m = min(m, dtw(a, digits{i}));
    end
    y = m;
end
