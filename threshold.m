% function for computing threshold for speaker+digit verification
%
% users -- matrix of distances between user's uterances of the same digit
%
% intruders -- matrix of distances between user recordings and intruder
% recordings
%
% fpr -- maximal allowed false positives rate
%
% returns threshold and false negatives rate (computed from user vector)

function [threshold, fnr]  = threshold(users, intruders, fpr)
    intruders = sort(intruders(:));

    index = floor(length(intruders) * fpr);
    threshold = 0;
    if index > 0
        threshold = intruders(index);
    end
    if index < length(intruders)
        threshold = threshold + intruders(index+1);
    else
        threshold = Inf;
    end

    threshold = threshold / 2;

    fnr = sum(sum(users >= threshold)) / length(users(:));

end
