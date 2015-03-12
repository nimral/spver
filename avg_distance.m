function y = avg_distance(a, digits)
    summa = 0
    for i = 1:length(digits)
        summa = summa + dtw(a, digits{i});
    end
    y = summa / length(digits);
end
        
    
