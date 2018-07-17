function [cfun, dfun] = poly2yrange(shape)
    [~, y] = boundary(shape);
    function yr = yrange(xx)
        yr = ones([2, size(xx)]) * NaN;
        N = length(xx(:));
        for idx = 1:N
            lineseg = [xx(idx), min(y); xx(idx), max(y)];
            [in, ~] = intersect(shape, lineseg);
            yri = in(:,2);
            yr(1, idx) = min(yri);
            yr(2, idx) = max(yri);
        end
    end
    function mout = index1(idx, m)
        sz = size(m);
        mout = reshape(m(idx, :), sz(2:end));
    end
    cfun = @(xx) index1(1, yrange(xx));
    dfun = @(xx) index1(2, yrange(xx));
end