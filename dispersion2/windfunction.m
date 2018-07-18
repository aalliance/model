function windf = windfunction(fits_vx, fits_vy)
% WIND Returns the interpolated wind vectors
% [vx, vy, dxv, dyv] = WIND(TQ, X, Y) returns a matrix with the x and y 
% components of the interpolated wind vector at the query points at time t
% as well its partial derivatives

global tinterp
uconv = (1/20)*24*60*60; % seconds per day
memo = containers.Map;

windf = @wind;
    function [vx, vy, dxv, dyv] = wind(tq, x, y)
        if isnan(tq)
            n = length(x);
            vx = ones(1, n)*NaN;  vy = ones(1, n)*NaN;
            dxv = ones(1, n)*NaN; dyv = ones(1, n)*NaN;
            return
        end
        [~, tqcind] = min(abs(tinterp-tq));
        tqc = tinterp(tqcind);
        hashval = strcat(char(typecast([0;tqc],'uint8')'), ...
                         char(typecast([0;x(:)],'uint8')'), ...
                         char(typecast([0;y(:)],'uint8')'));
        if isKey(memo, hashval)
            out = memo(hashval);
            vx = out(:,1)';
            vy = out(:,2)';
            dxv = out(:,3)';
            dyv = out(:,4)';
        else
            vx = uconv*feval(fits_vx(tqc), x, y);
            vy = uconv*feval(fits_vy(tqc), x, y);
            %[dxv, ~] = differentiate(fits_vx(tqc), x, y);
            %[~, dyv] = differentiate(fits_vy(tqc), x, y);
            dxv = fits_vx(tqc).dup
            dxv.derivative = 1
            dyv = fits_vy(tqc).dup
            dyv.derivative = 2
            dxv = uconv*dxv;
            dyv = uconv*dyv;
            out = [vx', vy', dxv', dyv'];
            memo(hashval) = out;
        end
    end
end


