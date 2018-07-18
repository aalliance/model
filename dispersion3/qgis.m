tidx = 100;
Ci = C(:, tidx);
%T = table(Ci, [croi(:).OBJECTID]');
%writetable(T,'concentration.csv','WriteRowNames',true) 
croi2 = croi;
for idx = 1:length(Ci)
    croi2(idx).CONC = Ci(idx);
end
fall = flipud(autumn(numel(Ci)));
concColors = makesymbolspec('Polygon', {'CONC', ...
   [0 max(Ci)], 'FaceColor', fall});
mapshow(croi2, 'SymbolSpec', concColors);