names = {'adam', 'jonatan', 'matej'};

vfprs = zeros(1, 3);
vfnrs = zeros(1, 3);

nums = zeros(3);
accepts = zeros(3);

for n = 1:10
    for i = 1:3
        for j = 1:3
            if verify_person(names{i}, names{j})
                accepts(i, j) = accepts(i, j) + 1;
            end
            nums(i, j) = nums(i, j) + 1;
        end
    end
end
        
