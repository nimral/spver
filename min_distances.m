% returns a vector of minimum distances from samples in cell array a to samples
% in cell array b
function ds = min_distances(a, b)
    ds = zeros(length(a), 1);

    for i = 1:length(a)
        ds(i) = min_distance(a{i}, b);
    end
end
