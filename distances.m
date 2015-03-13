% returns a matrix of DTW distances between elements of cell arrays a, b
function ds = distances(a, b)
    ds = zeros(length(a), length(b));

    for i = 1:length(a)
        for j = 1:length(b)
            ds(i, j) = dtw(a{i}, b{j});
        end
    end
end
