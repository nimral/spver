% returns a vector of minimal DTW distances between elements of cell array a
function ds = min_inner_distances(a)
    ds = zeros(length(a), 1) + Inf;

    for i = 1:length(a)
        for j = 1:length(a)
            if i ~= j
                ds(i) = min(dtw(a{i}, a{j}), ds(i));
            end
        end
    end
end

