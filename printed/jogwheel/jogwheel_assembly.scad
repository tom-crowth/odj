// All of the parameters for the overall design

// set parameter values for size of parts


// All of the includes of various components...
// printed components
use <jogwheel_inner.scad>
use <jogwheel_bottom.scad>
use <jogwheel_outer.scad>
use <jogwheel_mid.scad>
use <retaining_ring.scad>

// off the shelf components
use <../../ots/pressure_sensor.scad>
use <../../ots/spring.scad>
use <../../ots/bearing.scad>

jogwheel_outer_rad = 125;
jogwheel_inner_rad = 90;
thickness = 3;

inner_wall = 12;
inner_thickness = 4;
inner_height = 15;
tooth_depth = 3;
tooth_height = 8;
tooth_width = 6.5;

jogwheel_mid_rad = 70;
jogwheel_mid_width = 18;
jogwheel_mid_height = 20;


ring_thickness = 7;
ring_width = 4.5;



// bearing parameters based on available product
bear_ID = 5;
bear_OD = 23;
bear_width = 7;
screw_length = 21;

// pressure sensor parameters based on available product
sensor_OD = 18.3;
sensor_thick = 0.4;
tab_length = 27 - 18.3/2;
tab_width = 6.6;

// spring parameters based on available product
spring_ID = 6;
spring_OD = 8;
spring_len = 20;
spring_wire_dia = 0.8;
spring_comp_factor = 0.8;

// bearing grooves
bearing_groove_dim = 14;
bearing_groove_depth = 1;

gen_base = 10;
spring_comp_length = spring_len * spring_comp_factor;
spring_base_supp_height = gen_base-3.5;
// spring_base_supp_height = gen_base;
spring_rad_offset = 62;

sensor_rad_offset = 60;
sensor_base_supp_height = gen_base;

// higher level parameter objects
bearing_dims = create_bearing_dims(bear_ID, bear_OD, bear_width);
sensor_dims = create_sensor_dims(sensor_OD, sensor_thick, tab_length, tab_width);
spring_dims = create_spring_dims(spring_ID, spring_OD, spring_len, spring_wire_dia);
tooth_params = [tooth_depth,tooth_height, tooth_width];
outer_ring_params = [ring_thickness, ring_width];
spring_params = [spring_rad_offset, spring_base_supp_height, spring_dims, spring_comp_factor];
sensor_params = [sensor_rad_offset, sensor_base_supp_height, sensor_dims];

// calculated off input parameters
mid_vert_offset = sensor_base_supp_height + sensor_thick + thickness;
jogwheel_height = jogwheel_outer_rad - jogwheel_inner_rad;
inner_bear_rad_offset = jogwheel_mid_rad - 10;
inner_bear_vert_offset = bear_OD / 2 + 3;
outer_bear_rad_offset = jogwheel_inner_rad + 1+6;
outer_bear_vert_offset = bear_OD / 2 + 1;
bearing_params = [outer_bear_rad_offset, outer_bear_vert_offset, inner_bear_rad_offset, inner_bear_vert_offset, bearing_dims, screw_length];

clearance = 1;
outer_clear = 5;
spring_diff = mid_vert_offset - (spring_base_supp_height + thickness);
bearing_grooves = [bearing_groove_dim, bearing_groove_depth, inner_bear_rad_offset, outer_bear_rad_offset];
clearances = [clearance, outer_clear, spring_diff];

// draw settings
$fn=50;

module jogwheel_assembly() {

    union() {
        inner_params = [jogwheel_inner_rad, inner_wall, inner_thickness, inner_height, tooth_params, bearing_grooves, clearances];
        translate([0,0,jogwheel_height-inner_height+8]) 
        jogwheel_inner(inner_params);
    
        outer_params = [jogwheel_outer_rad, jogwheel_inner_rad, jogwheel_height, thickness, bearing_params, tooth_params, bearing_grooves, clearances];
        translate([0,0,8])
        jogwheel_outer(outer_params);


        mid_params = [jogwheel_mid_rad, jogwheel_mid_width, jogwheel_mid_height, spring_params, bearing_params, clearances];
        translate([0, 0, mid_vert_offset]) 
        jogwheel_mid(mid_params);

        bottom_params = [jogwheel_outer_rad, thickness, outer_ring_params, spring_params, sensor_params, bearing_params, clearances];
        translate([0,0,0]) 
        jogwheel_bottom(bottom_params);

        translate([0,0,3])
        retaining_ring();

        // outer bearings mounted to jogwheel_outer 
        for (i = [0:2]) {
                rotate([0,0,60+i*120])
                translate([outer_bear_rad_offset, 0, outer_bear_vert_offset+5])
                rotate([0,90,0])
                bearing(bearing_dims);
        }

        // inner bearings mounted to jogwheel_mid
        for (i = [0:2]) {
            rotate([0,0,i*120])
            translate([inner_bear_rad_offset, 0, inner_bear_vert_offset+mid_vert_offset])
            // translate([inner_bear_rad_offset, 0, inner_bear_vert_offset+5.5])
            rotate([0,90,0])
            bearing(bearing_dims);

        }

        //springs 
        for (i = [0:2]) {
            rotate([0, 0, 120*i+60])
            translate([spring_rad_offset, 0, spring_base_supp_height+thickness])
            spring(spring_ID, spring_OD, spring_len*spring_comp_factor, spring_wire_dia);
        }

        //pressure sensors
        for (i = [0:2]) {
            rotate([0, 0, 120*i])
            translate([sensor_rad_offset, 0, sensor_base_supp_height+thickness])
            pressure_sensor(sensor_dims);
        }
    }
}
jogwheel_assembly();
