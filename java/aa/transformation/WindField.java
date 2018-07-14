package aa.transformation;

import static java.lang.Math.toRadians;
import static java.lang.Math.sin;
import static java.lang.Math.cos;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import java.io.IOException;

import java.nio.file.Path;

import java.text.SimpleDateFormat;
import java.text.ParseException;

import java.awt.geom.Point2D;

import aa.util.SimpleCSV;
import aa.projection.Projector;

public class WindField
{
    private static final SimpleDateFormat FORMAT = new SimpleDateFormat("yyyyMMddHHmm");
    private static final double MILLIS_PER_DAY = 86400 * 1000;

    private double NWLat;
    private double NWLon;
    private double SELat;
    private double SELon;

    private ArrayList<WindFieldEntry> entries;

    public WindField()
    {
        clearBounds();
    }

    public WindField(Path data, Date ref, Map<String,Point2D.Double> sites)
        throws IOException, ParseException
    {
        clearBounds();

        load(data, ref, sites);
    }

    public WindField(
            Path data,
            Date ref,
            Map<String,Point2D.Double> sites,
            Point2D.Double NWCorner,
            Point2D.Double SECorner
            ) throws IOException, ParseException
    {
        setBounds(NWCorner, SECorner);

        load(data, ref, sites);
    }

    public void load(Path data, Date ref, Map<String,Point2D.Double> sites)
        throws IOException, ParseException
    {
        SimpleCSV reader = new SimpleCSV(data);

        double ref_time = (double)ref.getTime();

        entries = new ArrayList<WindFieldEntry>();

        while (reader.hasNext())
        {
            String[] record = reader.nextRecord();

            if (
                    record.length >= 13 &&
                    record[0].matches("^[\\-A-Z. ]+$") &&
                    !record[8].equals("999") &&
                    record[9].equals("5") &&
                    !record[11].equals("999.99") &&
                    record[12].equals("5")
                    )
            {
                Point2D.Double coords = sites.get(record[0].trim());

                double x = coords.getX();
                double y = coords.getY();

                if (NWLat <= x && NWLon <= y && x <= SELat && y <= SELon)
                {
                    double direction = toRadians(Double.parseDouble(record[8]));

                    double speed = Double.parseDouble(record[11]);

                    double time = (
                            (double)FORMAT.parse(record[3] + record[4]).getTime() -
                            ref_time
                            ) / MILLIS_PER_DAY;

                    entries.add(new WindFieldEntry(coords, direction, speed, time));
                }
            }
        }
    }

    public String toString()
    {
        StringBuilder rep = new StringBuilder();

        for (WindFieldEntry entry : entries)
        {
            rep.append(entry);
            rep.append('\n');
        }

        return rep.toString();
    }

    public void setBounds(Point2D.Double NWCorner, Point2D.Double SECorner)
    {
        NWLat = NWCorner.getX();
        NWLon = NWCorner.getY();

        SELat = SECorner.getX();
        SELon = SECorner.getY();
    }

    public void clearBounds()
    {
        NWLat = NWLon = Double.NEGATIVE_INFINITY;
        SELat = SELon = Double.POSITIVE_INFINITY;
    }
}

class WindFieldEntry
{
    private double posX, posY;
    private double velX, velY;
    private double time;

    WindFieldEntry(Point2D.Double coords, double direction, double speed, double time)
    {
        coords = Projector.project(coords);

        posX = coords.getX();
        posY = coords.getY();

        velX = speed * cos(direction);
        velY = speed * sin(direction);

        this.time = time;
    }

    public String toString()
    {
        return String.format("%f,%f,%f,%f,%f", posX, posY, velX, velY, time);
    }
}
