package aa.projection;

import static java.lang.Math.pow;
import static java.lang.Math.sqrt;
import static java.lang.Math.toRadians;
import static java.lang.Math.sin;
import static java.lang.Math.cos;
import static java.lang.Math.tan;

import java.awt.geom.Point2D;

public class Projector
{
    // Constants for GRS 80
    private static final double U_0 = -0.00504_82507_76;
    private static final double U_2 =  0.00002_12592_04;
    private static final double U_4 = -0.00000_01114_23;
    private static final double U_6 =  0.00000_00006_26;

    private static final double a = 6_378_137;
    private static final double r = 6_367_449.14577;
    private static final double e2 = 0.0066943800229034;
    private static final double ep2 = e2 / (1 - e2);

    // Constants for Arizona Central
    private static final double LAMBDA_0 = -(111 + 55. / 60);
    private static final double k_0 = 0.9999;
    private static final double S_0 = 3_430_631.2260;

    private static final double N_0 = 0;
    private static final double E_0 = 213_360;

    /*
        Inputs: phi (latitude) and lambda (longitude) in degrees
        Output: SPCS83 coordinates (easting, northing) in meters

        Pitfalls: does not work for points outside the Arizona Central zone
    */
    public static Point2D.Double project(double phi, double lambda)
    {
        double phi_rad = toRadians(phi);

        double cos_phi = cos(phi_rad);
        double sin_phi = sin(phi_rad);

        double L = toRadians(LAMBDA_0 - lambda) * cos_phi;

        double omega = phi_rad + sin_phi * cos_phi * (
                U_0 +
                U_2 * pow(cos_phi, 2) +
                U_4 * pow(cos_phi, 4) +
                U_6 * pow(cos_phi, 6)
                );

        double S = k_0 * omega * r;

        double R = k_0 * a / sqrt(1 - e2 * pow(sin_phi, 2));

        double t = tan(phi_rad);
        double t2 = pow(t, 2);

        double eta2 = ep2 * pow(cos_phi, 2);

        double A_2 = R * t / 2;
        double A_4 = (5 - t2 + eta2 * (9 + 4 * eta2)) / 12;

        double N = S - S_0 + N_0 + A_2 * pow(L, 2) + A_2 * A_4 * pow(L, 4);

        double A_1 = -R;
        double A_3 = (1 - t2 + eta2) / 6;
        double A_5 = (5 - 18 * t2 + pow(t, 4) + eta2 * (14 - 58 * t2)) / 120;

        double E = E_0 + A_1 * L + A_1 * A_3 * pow(L, 3) + A_1 * A_5 * pow(L, 5);

        return new Point2D.Double(E, N);
    }
}
