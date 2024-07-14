use <../../utility/ring.scad>
use <../../ots/bearing.scad>

module jogwheel_bottom(bottom_params) {

    bottom_outer_rad = bottom_params[0];
    bottom_thickness = bottom_params[1];
    outer_ring_params = bottom_params[2];
    spring_params = bottom_params[3];
    sensor_params = bottom_params[4];
    bearing_params = bottom_params[5];
    clearances = bottom_params[6];


    // unpack lower level params
    outer_ring_thickness = outer_ring_params[0];
    outer_ring_width = outer_ring_params[1];

    spring_rad_offset = spring_params[0];
    spring_base_supp_height = spring_params[1];
    spring_dims = spring_params[2];

    spring_OD = spring_dims[0];
    spring_ID = spring_dims[1];
    spring_len = spring_dims[2];

    sensor_rad_offset = sensor_params[0];
    sensor_base_supp_height = sensor_params[1];
    sensor_dims = sensor_params[2];

    sensor_OD = sensor_dims[0];

    outer_bear_rad_offset = bearing_params[0];
    outer_bear_vert_offset = bearing_params[1];
    inner_bear_rad_offset = bearing_params[2];
    inner_bear_vert_offset = bearing_params[3];
    bearing_dims = bearing_params[4];
    bear_ID = bearing_dims[0];
    bear_OD = bearing_dims[1];
    bear_width = bearing_dims[2];
    screw_length = bearing_params[5];

    clearance = clearances[0];
    outer_clear = clearances[1];

    // calculate other params from inputs


    bear_gap_width = bear_width + 2*clearance;

    bear_ret_circ_offset = 5;
    bear_ret_flat_width = 15;
    bear_ret_lrad = bear_OD*0.7 + 2*clearance;
    bear_ret_rad_diff = 2;
    bear_ret_srad = bear_ret_lrad - bear_ret_rad_diff;
    bearing_ret_params = [bear_ret_circ_offset, bear_ret_flat_width, bear_ret_lrad, bear_ret_rad_diff, bear_ret_srad];

    // a constant, shouldn't need to change
    bearing_ang_offset = 60;


    //color("blue")
    union() {
        // base plate
        cylinder(r=bottom_outer_rad + outer_clear, h=bottom_thickness);

        //ring at jogwheel outer
        translate([0, 0, bottom_thickness + outer_ring_width/2])
            ring(2*(bottom_outer_rad - outer_ring_thickness), 2*bottom_outer_rad, outer_ring_width);

        //spring retainers
        for(i = [0:2]) {
            rotate([0, 0, bearing_ang_offset + 120*i])
                translate([spring_rad_offset, 0, bottom_thickness]) {
                    // spring rod 
                    cylinder(d=spring_ID - 2*clearance, h=spring_len + 2*clearance);
                    // spring base
                    cylinder(r=spring_OD, h=spring_base_supp_height);
                }
        }

        //sensor pads
        for(i = [0:2]) {
            rotate([0,0,120*i])
                translate([sensor_rad_offset, 0, bottom_thickness])
                cylinder(d=sensor_OD+ 5*clearance, h=sensor_base_supp_height);
        }

        //bearing retainers
        for(i = [0:2]) {
            rotate([0,0,bearing_ang_offset + 120*i])
                translate([outer_bear_rad_offset, 0, bear_ret_circ_offset])
                rotate([0,90,0])
                difference(){
                    union(){
                        translate([0, 0, bear_ret_flat_width/2])
                            cylinder(r1=bear_ret_lrad, r2=bear_ret_srad, h=bear_ret_rad_diff);
                        cylinder(r=bear_ret_lrad, h=bear_ret_flat_width, center=true);
                    }
                    translate([bear_ret_lrad+bear_ret_circ_offset, 0, clearance])
                        cube(size=bear_ret_lrad*2 + clearance, center=true);

                    // cutouts for bearings
                    translate([-outer_bear_vert_offset, 0, 0])
                        union() {
                            cylinder(d=bear_ret_lrad, h=bear_gap_width, center=true);
                            translate([-bear_ret_lrad/2, 0, 0])
                                cube([bear_ret_lrad, bear_ret_lrad, bear_gap_width], center=true);
                            cylinder(d=bear_ID, h=screw_length, center=true);
                        }
                }
        }
    }
}


// // default values for testing, overwritten by assembly
// jogwheel_outer_rad = 125;
//
// ring_thickness = 7;
// ring_width = 4.5;
//
// bear_ID = 5;
// bear_OD = 23;
// bear_width = 7;
// bear_dims = create_bearing_dims(bear_ID, bear_OD, bear_width);
//
// spring_ID = 6;
// spring_OD = 8;
// spring_len = 20;
// spring_dims = [spring_ID, spring_OD, spring_len];
//
// spring_rad_offset = 55;
// spring_base_supp_height = ring_width;
// spring_params = [spring_rad_offset, spring_base_supp_height, spring_dims];
//
// sensor_OD = 18.3;
// sensor_thick = 0.4;
// sensor_rad_offset = 60;
// sensor_base_supp_height = ring_width;
// sensor_params = [sensor_rad_offset, sensor_base_supp_height];
//
//
// outer_bear_rad_offset = 92;
// outer_bear_vert_offset = 16.5;
//
// screw_length = 21;
//
//
//
//
// // set clearance distance
// clearance = 1;
// outer_clear = 5;
// thickness = 3;
// clearances = [clearance, outer_clear];
//
// // parameters set based on above
// base_thickness = thickness;
//
//
// outer_ring_params = [ring_thickness, ring_width];
// bottom_params = [jogwheel_outer_rad, thickness, outer_ring_params, spring_params, sensor_params, bear_dims, clearances];
//
// jogwheel_bottom(bottom_params);
jogwheel_bottom([125, 3, [7,4.5], [62,4.5,[6,8,20,0.8]], [60,4.5,[18.3,0.4,17.85,6.6]], [95,12.5,60,14.5,[5,23,7],21], [1,5]]);
