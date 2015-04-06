% Euclidean distance of two vectors a, b
function y = distance(a, b)
    m = length(a);
    y = sum((a-b) .^ 2) ^ (1/2);
end

