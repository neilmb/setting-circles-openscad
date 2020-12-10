// Azimuth circle for a newtonian telescope

$fa = 1;
$fs = 0.01;
$fn = 100;

// constants
INNER_RADIUS = 9.25 * 25.4;
OUTER_RADIUS = 10.25 * 25.4;

THICKNESS = 0.15 * 25.4;

MAJOR_TICK_LENGTH = 0.7 * (OUTER_RADIUS - INNER_RADIUS);
MINOR_TICK_LENGTH = MAJOR_TICK_LENGTH / 2;
TICK_WIDTH = 0.05 * 25.4;

module numeral(value)
{
    size = OUTER_RADIUS - INNER_RADIUS;
    translate([0, 0, 0.25 * THICKNESS]) color("blue") rotate(-90) linear_extrude(height = 1.25 * THICKNESS)
    {
        translate([ -.325 * 25.4, -0.95 * size, 0])
            text(value, font = "Lato;Style=Black", size = 0.4 * size);
    }
}

module tick(length, width, thickness)
{
    color("green") translate([ -length / 2, width / 2, thickness ])
        cube([ length, width, 1.25 * thickness ], center = true);
}

module
major_tick()
{
    tick(MAJOR_TICK_LENGTH - TICK_WIDTH / 2, TICK_WIDTH, THICKNESS);
}

module
minor_tick()
{
    tick(MINOR_TICK_LENGTH - TICK_WIDTH / 2, TICK_WIDTH, THICKNESS);
}

module ring(inner, outer, height)
{
    // Make a solid ring with and inner radius, outer radius, and height
    translate([ 0, 0, height / 2 ]) difference()
    {
        cylinder(r = outer, h = height, center = true);
        cylinder(r = inner, h = 2 * height, center = true);
    }

    // Add an outer rim
    color("green") translate([ 0, 0, height ]) difference()
    {
        cylinder(r = outer, h = 1.25 * height, center = true);
        cylinder(r = outer - TICK_WIDTH, h = 3 * height, center = true);
    }
}

module
setting_circle()
{
    ring(INNER_RADIUS, OUTER_RADIUS, THICKNESS);

    N_MAJOR_TICKS = 36;
    for (i = [0:N_MAJOR_TICKS - 1]) {
        angle = i * 360 / N_MAJOR_TICKS;
        rotate(angle) translate([ OUTER_RADIUS - TICK_WIDTH / 2, 0, 0 ]) major_tick();

        // Add numbers to the major ticks

        rotate(-angle) translate([ OUTER_RADIUS, 0, 0 ]) numeral(str(angle));
    }

    N_MEDIUM_TICKS = 72;
    for (i = [0:N_MEDIUM_TICKS - 1]) {
        rotate(i * 360 / N_MEDIUM_TICKS)
        {
            translate([ OUTER_RADIUS - TICK_WIDTH / 2, 0, 0 ])
                tick((MAJOR_TICK_LENGTH + MINOR_TICK_LENGTH) / 2 - TICK_WIDTH / 2,
                     TICK_WIDTH,
                     THICKNESS);
        }
    }

    N_MINOR_TICKS = 360;
    for (i = [0:N_MINOR_TICKS - 1]) {
        rotate(i * 360 / N_MINOR_TICKS)
        {
            translate([ OUTER_RADIUS - TICK_WIDTH / 2, 0, 0 ]) minor_tick();
        }
    }
}

// uncomment to debug this module
//setting_circle();