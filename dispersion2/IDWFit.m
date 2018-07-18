classdef IDWFit
    properties
        P = 2

        dataCoords
        numCoords
        dataVals
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
            fitobj.dataCoords = coords.'
            fitobj.numCoords = size(coords, 1)
            fitobj.dataVals = vals
        end

        function u = fit(self, coords)
            weights = self.norms(coords).^(-self.P)

            u = (weights * self.dataVals) ./ sum(weights, 2)
        end

        function du = partial(self, coords, dim)
            ns = self.norms(coords)

            elPack = ones(size(coords, 1), 1)

            coordD = repmat(coords(:, dim), 1, self.numCoords)
            dataD = kron(self.dataCoords(dim, :), elPack)

            weights = ns.^(-self.P)
            dweights = -self.P * ns.^(-(self.P + 2)) .* (coordD - dataD)
            s = sum(weights, 2)

            du = ((dweights * self.dataVals) .* s - (weights * self.dataVals) .* sum(dweights, 2)) ./ s.^(2)
        end
    end
end
