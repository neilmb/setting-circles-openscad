// Cut the setting circle

include <setting_circle.scad>

$fa = 1;
$fs = 0.01;
$fn = 100;

CUTTER_RADIUS = 0.25 * 25.4;
HALF_KERF = 0.0025 * 25.4;

INF = 5000;

module
puzzle_cutter()
{
    union()
    {
        translate([ 0, -INF / 2 + HALF_KERF, 0 ]) cube([ INF, INF, INF ], center = true);
        translate([ 0, CUTTER_RADIUS / 2, 0 ])
            cylinder(r = CUTTER_RADIUS + HALF_KERF, h = INF, center = true);
    }
}

module
puzzle_adder()
{
    difference()
    {
        translate([ 0, INF / 2 - HALF_KERF, 0 ]) cube([ INF, INF, INF ], center = true);
        translate([ 0, CUTTER_RADIUS / 2, 0 ])
            cylinder(r = CUTTER_RADIUS - HALF_KERF, h = INF, center = true);
    }
}

difference()
{
    // cut the concave side out
    difference()
    {
        setting_circle();
        translate([ (INNER_RADIUS + OUTER_RADIUS) / 2, 0, 0 ]) puzzle_cutter();
    }
    // now cut on the convex side
    rotate(45) translate([ (INNER_RADIUS + OUTER_RADIUS) / 2, 0, 0 ])
        puzzle_adder();
}