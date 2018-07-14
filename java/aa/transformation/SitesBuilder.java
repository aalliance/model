package aa.transformation;

import java.util.HashMap;
import java.util.List;

import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Path;

import java.awt.geom.Point2D;

public class SitesBuilder
{
    public static HashMap<String,Point2D.Double> build(Path stations) throws IOException
    {
        List<String> data = Files.readAllLines(stations);

        HashMap<String,Point2D.Double> sites = new HashMap<String,Point2D.Double>();

        for (int i = 2; i < data.size(); ++i)
        {
            String record = data.get(i);

            String key = record.substring(13, 43).trim();

            double lat = Double.parseDouble(record.substring(126, 134));
            double lon = Double.parseDouble(record.substring(135, 144));

            sites.put(key, new Point2D.Double(lat, lon));
        }

        return sites;
    }
}
