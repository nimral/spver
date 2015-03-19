function y = modify_database(database)
names = {'adam', 'jonatan', 'matej'};
new = {};

for n = 1:length(names)
    for dig = 0:9
        digit = dig;
        if dig == 0
            digit = 10;
        end

        test_index = 1;
        train_index = 1;

        for rec = 1:length(database{n}{digit})
            if rand() < 0.5
                new{n}{digit}{train_index} = database{n}{digit}{rec};
                train_index = train_index + 1;
            else
                new{n+3}{digit}{test_index} = database{n}{digit}{rec};
                test_index = test_index + 1;
            end
        end
    end
end
%database = new;
y = new;

%save('database.mat', 'database');
end
