% function computing Dynamic time warping distance between two matrices A, B
% representing sequences of rows, distance of rows is computed by Euclidean
% metric

function [y, path] = dtw(A, B)
    lA = size(A, 1);
    lB = size(B, 1);

    % table for dynamic programming
    tab = zeros(lA, lB) + Inf;

    tab(1,1) = distance(A(1, :), B(1, :));

	% Here we have to be very careful. If we are not going to detect the silence,
	% then we have to be more tolerant, because we don't know when, during the
	% aprox 2s time window, the speaker is going to start speaking. Therefore,
	% I suggest to increase the tolerance.
    tol = 0.4;


    % first row
    for b = 2:min(lB, floor((lB / lA) + lB*tol))
        tab(1, b) = distance(A(1, :), B(b, :)) + tab(1, b-1);
    end


    % general case
    for a = 2:lA
        
        % only window
        from = max(1, ceil(a * (lB / lA) - lB*tol));
        to = min(lB, floor(a * (lB / lA) + lB*tol));

        
        % first valid position on the row
        b = from;
        upper = tab(a-1, b);
        upperleft = Inf;
        if dtw_in(a-1, b-1, lA, lB)
            upperleft = tab(a-1, b-1);
        end

        % weight coefficient -- manhattan distance from last point
        w = 1 + (upperleft < upper);

        tab(a, b) = w * distance(A(a, :), B(b, :)) + min([upper, upperleft]);


        for b = (from+1):to
            
            % using adjustment window -- only take the positions inside the
            % window into consideration
            left = tab(a, b-1);
            upper = tab(a-1, b);
            upperleft = tab(a-1, b-1);

            % weight coefficient -- manhattan distance from last point
            w = 1 + (upperleft < min([upper, left]));

            tab(a, b) = w * distance(A(a, :), B(b, :)) + min([upper, left, upperleft]);

        end
    end

    % value of the best alignment of the two sequences
    % normalized

    y = tab(lA, lB) / (lA + lB);
end

