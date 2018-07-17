function [cfun, dfun] = poly2yrange(shape)
    [~, y] = boundary(shape);
    function yr = yrange(xx)
        lineseg = [xx, min(y); xx, max(y)];
        [in, ~] = intersect(shape, lineseg);
        yr = in(:,2);
    end
    cfun = @(z) min(yrange(z));
    dfun = @(z) max(yrange(z));
end