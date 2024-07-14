// // some defaults for testing
// jogwheel_mid_rad = 70;
//
// spring_OD = 8;
// spring_len = 20;
// spring_comp_factor = 0.8;
//
// clearance = 1;



module jogwheel_mid(mid_params) {

    mid_outer_rad = mid_params[0];
    mid_width = mid_params[1];
    mid_height = mid_params[2];
    spring_params = mid_params[3];
    bearing_params = mid_params[4];
    clearances = mid_params[5];

    mid_inner_rad = mid_outer_rad - mid_width;

    spring_rad_offset = spring_params[0];
    spring_dims = spring_params[2];
    spring_comp_factor = spring_params[3];

    spring_OD = spring_dims[1];
    spring_len = spring_dims[2];

    inner_bear_rad_offset = bearing_params[2];
    inner_bear_vert_offset = bearing_params[3];
    bearing_dims = bearing_params[4];
    screw_length = bearing_params[5];
    bearing_shaft = bearing_dims[0];

    clearance = clearances[0];
    spring_diff = clearances[2];

    difference() {

        cylinder(r=mid_outer_rad, h=mid_height);        
        union() {
            // cutouts for bearings
            for (i = [0:2]) {
                rotate([0,0,i*120])
                    translate([inner_bear_rad_offset, 0, inner_bear_vert_offset])
                    union() {
                        rotate([0,90,0])
                            union() {
                                cylinder(d=bearing_shaft, h=screw_length, center=true);
                            }
                        cube([8,26,30], center=true);
                    }
            }

            //cutouts for springs
            for (i = [0:2]) {
                rotate([0,0,60+i*120])
                    translate([0, 0, -clearance]) 
                    translate([spring_rad_offset, 0, 0]) 
                    cylinder(d=spring_OD+2*clearance, h=spring_len*spring_comp_factor-spring_diff);
            }

            // cutout in centre
            translate([0,0,-clearance])
                cylinder(r=mid_inner_rad, h=mid_height+2*clearance);
        }
    }
            // for (i = [0:2]) {
            //     rotate([0,0,60+i*120])
            //         translate([0, 0, -clearance]) 
            //         translate([spring_rad_offset, 0, 0]) 
            //         cylinder(d=spring_OD+2*clearance, h=spring_len*spring_comp_factor);
            // }
}

// set up input params for test module

// mid_outer_rad = jogwheel_mid_rad;
// mid_width = 22;
// mid_height = 20;

// mid_params = [mid_outer_rad, mid_width, mid_height, spring_params, bearing_params, clearances];
mid_params = [70, 18, 20, [60,4.5,[6,8,20,0.8], 0.8], [91,16.5, 60, 14.5, [5,23,7], 21], [1,5]];

jogwheel_mid(mid_params);

