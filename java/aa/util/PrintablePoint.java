package aa.util;

import java.awt.geom.Point2D;

/*
   Example of how to generate a CSV file using this class:

   for (PrintablePoint P : list)
   {
       System.out.println(p);
   }

   Run the code with: java MainClass > data.csv

   Or you can write the file from Java, if you want to deal with that sort of shit.
*/
public class PrintablePoint extends Point2D.Double
{
    public PrintablePoint()
    {
        super();
    }

    public PrintablePoint(double x, double y)
    {
        super(x, y);
    }

    public String toString()
    {
        return String.format("%f,%f", x, y);
    }
}
