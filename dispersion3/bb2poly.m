function p = bb2poly(bb)
%BB2POLY Returns a polyshape from a bounding box
  x = [bb(1) bb(1) bb(2) bb(2)];
  y = [bb(3) bb(4) bb(4) bb(3)];
  p = polyshape(x, y);
end

