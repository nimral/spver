% function computing Dynamic time warping distance between two matrices A, B
% representing sequences of rows, distance of rows is computed by Euclidean
% metric
function y = dtw(A, B)
    lA = size(A, 1);
    lB = size(B, 1);

    % table for dynamic programming
    tab = zeros(lA, lB) + Inf;

    tab(1,1) = distance(A(1, :), B(1, :));

    % prefill first column
    for a = 2:lA
        tab(a, 1) = tab(a-1, 1) + distance(B(1, :), A(a, :));
    end

    % prefill first row
    for b = 2:lB
        tab(1, b) = tab(1, b-1) + distance(B(b, :), A(1, :));
    end

    % general case
    for a = 2:lA
        for b = 2:lB
            tab(a, b) = distance(A(a, :), B(b, :)) + min([tab(a-1, b), tab(a-1, b-1), tab(a, b-1)]);
        end
    end

    % value of the best alignment of the two sequences
    y = tab(lA, lB);
end

