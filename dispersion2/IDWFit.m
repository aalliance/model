classdef IDWFit
    properties
        P = 2

        dataCoords
        numCoords
        dataVals
        derivative = 0
    end

    methods (Access = private)
        function n = norms(self, coords)
            elPack = ones(size(coords, 1), 1);

            coordX = repmat(coords(:, 1), 1, self.numCoords);
            coordY = repmat(coords(:, 2), 1, self.numCoords);

            dataX = kron(self.dataCoords(1, :), elPack);
            dataY = kron(self.dataCoords(2, :), elPack);

            n = sqrt((coordX - dataX).^2 + (coordY - dataY).^2);
        end
    end

    methods
        function fitobj = IDWFit(coords, vals)
            fitobj.dataCoords = coords.';
            fitobj.numCoords = size(coords, 1);
            fitobj.dataVals = vals;
        end

        function fitobj = dup(self)
            fitobj = IDWFit(self.dataCoords.', self.dataVals);
            fitobj.P = self.P;
            fitobj.derivative = self.derivative;
        end

        function u = subsref(self, S)
            if S.type == '()'
                if self.derivative == 0
                    weights = self.norms(S.subs{1}).^(-self.P);

                    u = (weights * self.dataVals) ./ sum(weights, 2);
                else
                    coords = S.subs{1};

                    ns = self.norms(coords);

                    coordD = repmat(coords(:, self.derivative), 1, self.numCoords);
                    dataD = kron(self.dataCoords(self.derivative, :), ones(size(coords, 1), 1));

                    weights = ns.^(-self.P);
                    dweights = -self.P * ns.^(-(self.P + 2)) .* (coordD - dataD);
                    s = sum(weights, 2);

                    u = ((dweights * self.dataVals) .* s - (weights * self.dataVals) .* sum(dweights, 2)) ./ s.^(2);
                end
            else
                u = builtin('subsref', self, S(1));
            end
        end
    end
end
