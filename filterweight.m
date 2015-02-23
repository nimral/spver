% returns the weight of triangular filter with width 2*d at position x
% centre -- of the filter
% d -- half the width of the triangle
% x -- position
function weight = filterweight(centre, d, x)
    % filter weight is 1 at centre, 0 at centre +- d, triangular
    % shape
    % what is the weight of the filter at position x?
    if x < centre && x > centre - d
        weight = (x - (centre - d)) / d;
    elseif x >= centre && x < centre + d
        weight = ((centre + d) - x) / d;
    else
        weight = 0;
    end
end
    
