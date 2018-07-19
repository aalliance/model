fall = flipud(autumn(1000));
concColors = makesymbolspec('Polygon', {'CONC', ...
   [0 max(C(:))], 'FaceColor', fall});
croi2 = croi;
skip = 5;
for j = 1:(length(tlist)/skip)
    Ci = C(:, j*skip);
    for idx = 1:length(Ci)
        croi2(idx).CONC = Ci(idx);
    end
    mapshow(croi2, 'SymbolSpec', concColors);
    MvMap(j) = getframe;
end
mov2mp4(MvMap, 'mapconc.mp4', 2)
% fig = figure; movie(fig,MvMap,1);
% imshow(MvMap(2).cdata;