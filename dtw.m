% function computing Dynamic time warping distance between two matrices A, B
% representing sequences of rows, distance of rows is computed by Euclidean
% metric

function y = dtw(A, B)
    lA = size(A, 1);
    lB = size(B, 1);

    % table for dynamic programming
    tab = zeros(lA, lB) + Inf;

    tab(1,1) = distance(A(1, :), B(1, :));

    % general case
    for a = 2:lA
        for b = 2:lB
            
            % using adjustment window -- only take the positions inside the
            % window into consideration
            left = Inf;
            if dtw_in(a, b-1, lA, lB)
                left = tab(a-1, b);
            end

            upper = Inf;
            if dtw_in(a-1, b, lA, lB)
                upper = tab(a, b-1);
            end

            upperleft = Inf;
            if dtw_in(a-1, b-1, lA, lB)
                upperleft = tab(a-1, b-1);
            end

            tab(a, b) = distance(A(a, :), B(b, :));
            tab(a, b) += min([upper, left, upperleft]);
        end
    end

    % value of the best alignment of the two sequences
    y = tab(lA, lB);
end

