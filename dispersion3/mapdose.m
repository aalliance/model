fall = flipud(autumn(1000));
concColors = makesymbolspec('Polygon', {'CINTEG', ...
   [0 max(Cinteg(:))], 'FaceColor', fall});
croi2 = croi;
skip = 5;
for j = 1:(length(tlist)/skip)
    Cintegi = Cinteg(:, j*skip);
    for idx = 1:length(Cintegi)
        croi2(idx).CINTEG = Cintegi(idx);
    end
    mapshow(croi2, 'SymbolSpec', concColors);
    MvMapDose(j) = getframe;
end
mov2mp4(MvMapDose, 'mapdose.mp4', 2)
% fig = figure; movie(fig,MvMapDose,1);
% imshow(MvMapDose(2).cdata;