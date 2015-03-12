% function computing Dynamic time warping distance between two matrices A, B
% representing sequences of rows, distance of rows is computed by Euclidean
% metric

function [y, path] = dtw(A, B)
    lA = size(A, 1);
    lB = size(B, 1);

    % table for dynamic programming
    tab = zeros(lA, lB) + Inf;

    % saving path
    path = zeros(lA, lB);
    % left, upperleft, upper
    directions = [[0, -1]; [-1, -1]; [-1, 0]];

    tab(1,1) = distance(A(1, :), B(1, :));

    % general case
    for a = 1:lA
        for b = 1:lB
            
            if (a == 1) && (b == 1)
                continue;
            end
            
            % using adjustment window -- only take the positions inside the
            % window into consideration
            left = Inf;
            if dtw_in(a, b-1, lA, lB)
                left = tab(a, b-1);
            end

            upper = Inf;
            if dtw_in(a-1, b, lA, lB)
                upper = tab(a-1, b);
            end

            upperleft = Inf;
            if dtw_in(a-1, b-1, lA, lB)
                upperleft = tab(a-1, b-1);
            end

            % weight coefficient -- manhattan distance from last point
            w = 1;
            if upperleft < min([upper, left])
                w = 2;
            end

            tab(a, b) = w * distance(A(a, :), B(b, :)) + min([upper, left, upperleft]);

            if left <= min([upper, upperleft])
                path(a, b) = 1;
            end
            if upperleft < min([left, upper])
                path(a, b) = 2;
            end
            if upper <= min([left, upperleft])
                path(a, b) = 3;
            end

        end
    end

    % value of the best alignment of the two sequences
    % normalized
            
    y = tab(lA, lB) / (lA + lB);


    path(1, 1) = 99;
    
    a = lA;
    b = lB;
    while path(a, b) ~= 99
        tmp = path(a, b);
        path(a, b) = 99;
        tmp = directions(tmp, :);
        a = a + tmp(1);
        b = b + tmp(2);
    end
end

