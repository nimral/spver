% Euclidean distance of two vectors a, b
function y = distance(a, b)
    y = sum((a-b) .^ 2) ^ (1/2);
end

