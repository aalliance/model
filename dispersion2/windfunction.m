function windf = windfunction(fits_vx, fits_vy)
% WIND Returns the interpolated wind vectors
% [vx, vy, dxv, dyv] = WIND(TQ, X, Y) returns a matrix with the x and y 
% components of the interpolated wind vector at the query points at time t
% as well its partial derivatives

global tinterp;
%global tstep;
wfac = 2500;
memo = containers.Map;

windf = @wind;
    function [vx, vy, dxv, dyv] = wind(tq, x, y)
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
            vx = wfac*feval(fits_vx(tqc), x, y);
            vy = wfac*feval(fits_vy(tqc), x, y);
            [dxv, ~] = differentiate(fits_vx(tqc), x, y);
            [~, dyv] = differentiate(fits_vy(tqc), x, y);
            dxv = wfac*dxv;
            dyv = wfac*dyv;
            out = [vx', vy', dxv', dyv'];
            memo(hashval) = out;
        end
    end
end


