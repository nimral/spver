names = {'adam', 'jonatan', 'matej'};

database = {};
for n = 1:length(names)
    for dig = 0:9
        digit = dig;
        if dig == 0
            digit = 10;
        end

        listings = dir(strcat(names{n}, '_recording_', int2str(digit), '_*.wav'));
        i = 1;
        for file = listings'
            database{n}{digit}{i} = mfcc(file.name);
            i = i+1;
        end
    end
end
save('database', 'database');

for n = 1:1
    summa = 0;
    num = 0;
    digit = 1;
    for i = 1:length(database{n}{digit})
        for j = (i+1):length(database{n}{digit})
            summa = summa + dtw(database{n}{digit}{i}, database{n}{digit}{j});
            num = num + 1;
        end
    end
    summa / num
end

