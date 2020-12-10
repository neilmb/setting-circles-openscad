// Cut the setting circle: piece 2

include <setting_circle.scad>

$fa = 1;
$fs = 0.01;
$fn = 100;

use <setting_circle1.scad>

difference()
{
    // cut the concave side out
    difference()
    {
        setting_circle();
        rotate(45) translate([ (INNER_RADIUS + OUTER_RADIUS) / 2, 0, 0 ]) puzzle_cutter();
    }
    // now cut on the convex side
    rotate(90) translate([ (INNER_RADIUS + OUTER_RADIUS) / 2, 0, 0 ])
        puzzle_adder();
}