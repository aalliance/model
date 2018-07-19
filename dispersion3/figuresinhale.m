global begin_r end_r

maxCinteg = max(Cinteg(:));
fall = flipud(autumn(1000));
inhaleColors = makesymbolspec('Polygon', {'INHALED', ...
   [0 maxCinteg], 'FaceColor', fall});
croi2 = croi;

for time = 0.5:0.5:2
    [~, j] = min(abs(tlist-(t_begin+time)));
    Ci = Cinteg(:, j);
    for idx = 1:length(Ci)
        croi2(idx).INHALED = Ci(idx);
    end
    figure;
    mapshow(croi2, 'SymbolSpec', inhaleColors);
    colormap(fall);
    colorbar;
    caxis([0 maxCinteg]);
    xlabel("Easting");
    ylabel("Northing");
    hold on;
    plot([begin_r(1) end_r(1)]./sft2m, [begin_r(2) end_r(2)]./sft2m, 'b-', 'LineWidth', 2);
    hold off;
    saveas(gcf,strcat('InhalationByDay', num2str(time), '.png'))
end

