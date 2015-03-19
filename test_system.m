% Script for computing thresholds and FNRs

database = load('database.mat');
database = database.database;

% Maximal allowed false positives rate for one digit
fpr = 0.2;

thresholds = zeros(10, 3);
fnrs = zeros(10, 3);
fprs = zeros(10, 3);

for dig = 1:10
    fprintf('starting digit %d\n', dig);
    for n = 1:3
        fprintf('user %d\n', n);
        fflush(stdout);
        nXn = inner_distances(database{n}{dig});

        nXothers = [];
        for o = 1:3
            if o == n
                continue;
            end

            dists = distances(database{o}{dig}, database{n}{dig});
            nXothers = [nXothers (dists(:))'];
        end

        [thresholds(dig, n), fnrs(dig, n), fprs(dig, n)] = threshold(nXn, nXothers, fpr);
    end
    thresholds
    fnrs
end
