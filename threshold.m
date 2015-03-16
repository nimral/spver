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

function [thr, fnr, fpr]  = threshold(users, intruders, max_allowed_fpr)
    
    intruders = intruders(:);
    lIntruders = length(intruders);
    users = users(:);
    lUsers = length(users);

    intruders = [intruders zeros(lIntruders, 1)];
    users = [users ones(lUsers, 1)];

    sorted = sortrows([intruders ; users]);
    lSorted = lIntruders + lUsers;

    thr = 0.0;
    fpr = 0.0;
    fnr = 1.0;
    past_users = 0;
    past_intrs = 0;
    fitness = get_fitness(fnr, fpr);
    for i = 1:(lSorted-1)
        thr2 = (sorted(i, 1) + sorted(i+1, 1)) / 2;
        if sorted(i, 2) == 1
            past_users = past_users + 1;
        elseif sorted(i, 2) == 0
            past_intrs = past_intrs + 1;
        end

        fpr2 = past_intrs / lIntruders;
        if fpr2 > max_allowed_fpr
            break;
        end

        fnr2 = (lUsers - past_users) / lUsers;

        if fitness < get_fitness(fnr2, fpr2)
            fpr = fpr2;
            fnr = fnr2;
            thr = thr2;
            fitness = get_fitness(fnr2, fpr2);
        end
    end;
end
