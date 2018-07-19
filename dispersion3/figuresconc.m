global begin_r end_r

maxC = max(C(:));
fall = flipud(autumn(1000));
concColors = makesymbolspec('Polygon', {'CONC', ...
   [0 maxC], 'FaceColor', fall});
croi2 = croi;

for time = 0.5:0.5:2
    [~, j] = min(abs(tlist-(t_begin+time)));
    Ci = C(:, j);
    for idx = 1:length(Ci)
        croi2(idx).CONC = Ci(idx);
    end
    figure;
    mapshow(croi2, 'SymbolSpec', concColors);
    colormap(fall);
    colorbar;
    caxis([0 maxC]);
    xlabel("Easting");
    ylabel("Northing");
    hold on;
    plot([begin_r(1) end_r(1)]./sft2m, [begin_r(2) end_r(2)]./sft2m, 'b-', 'LineWidth', 2);
    hold off;
    saveas(gcf,strcat('ConcentrationAtDay', num2str(time), '.png'))
end

