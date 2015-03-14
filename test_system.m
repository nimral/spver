database = load('database.mat').database;

fpr = 0.05;

thresholds = zeros(10, 3);
fnrs = zeros(10, 3);

for dig = 1:10
    fprintf('starting digit %d\n', dig);
    for n = 1:3
        fprintf('user %d\n', n);
        nXn = inner_distances(database{n}{dig});

        nXothers = [];
        for o = 1:4
            if o == n
                continue;
            end

            nXothers = [nXothers (distances(database{n}{dig}, database{o}{dig})(:))'];
        end

        [thresholds(dig, n), fnrs(dig, n)] = threshold(nXn, nXothers, fpr);
    end
end

thresholds
fnrs
