% returns a vector of DTW distances between elements of cell array a
function ds = inner_distances(a)
    ds = [];

    for i = 1:length(a)
        for j = (i+1):length(a)
            ds(end+1) = dtw(a{i}, a{j});
        end
    end
end
