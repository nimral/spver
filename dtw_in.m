% auxiliary function for DTW
% test whether position (a, b) is in the adjustment window
% lA, lB are lenghts of the sequences A, B
function y = dtw_in(a, b, lA, lB)
    %tolerance
    tol = 1;
    y = (a > 0) && (b > 0) && (b < (a * (lB / lA) + lB*tol)) && (b > (a * (lB / lA) - lB*tol));
end
