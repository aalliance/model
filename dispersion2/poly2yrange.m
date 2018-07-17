function [cfun, dfun] = poly2yrange(shape)
    [~, y] = boundary(shape);
    function yr = cfun1(xx)
        yr = ones(size(xx)) * NaN;
        N = length(xx(:));
        for idx = 1:N
            lineseg = [xx(idx), min(y); xx(idx), max(y)];
            [in, ~] = intersect(shape, lineseg);
            yri = in(:,2);
            yr(idx) = min(yri);
        end
    end
    function yr = dfun1(xx)
        yr = ones(size(xx)) * NaN;
        N = length(xx(:));
        for idx = 1:N
            lineseg = [xx(idx), min(y); xx(idx), max(y)];
            [in, ~] = intersect(shape, lineseg);
            yri = in(:,2);
            yr(idx) = max(yri);
        end
    end
    cfun = @cfun1;
    dfun = @dfun1;
end