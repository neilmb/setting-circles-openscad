// Cut the setting circle: piece 1

include <setting_circle.scad>

$fa = 1;
$fs = 0.01;
$fn = 100;

use <sliced_setting_circle.scad>

sliced_setting_circle(270, 315);
