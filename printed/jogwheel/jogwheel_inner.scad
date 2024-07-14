// $fn=250;

// // set default value
// jogwheel_inner_rad = 90;
//
// inner_wall = 12;
// inner_thickness = 4;
// inner_height = 15;
//
// clearance = 1;
//
// tooth_depth = 3;
// tooth_height = 8;
// tooth_width = 6.5;  // this is an angle

// parameters based on input params

module jogwheel_inner(inner_params) {
    // unpack input params
    inner_rad = inner_params[0];
    inner_wall = inner_params[1];
    inner_thickness = inner_params[2];
    inner_height = inner_params[3];
    tooth_params = inner_params[4];
    bearing_grooves = inner_params[5];
    clearances = inner_params[6];

    tooth_depth = tooth_params[0];
    tooth_height = tooth_params[1];
    tooth_width = tooth_params[2];
    
    bearing_groove_dim = bearing_grooves[0];
    bearing_groove_depth = bearing_grooves[1];
    inner_bearing_groove_rad = bearing_grooves[2];

    clearance = clearances[0];

    part_inner_rad = inner_rad - clearance;

    difference() {

        rotate_extrude()
        polygon( points=[[0, inner_height],
            [part_inner_rad, inner_height],
            [part_inner_rad, inner_height-inner_thickness],
            [part_inner_rad+tooth_depth, tooth_height],
            [part_inner_rad+tooth_depth, 0],
            [part_inner_rad-inner_wall, 0],
            [part_inner_rad-inner_wall, inner_height-inner_thickness],
            [0, inner_height-inner_thickness]] );
                
        for ( i = [0 : 2] ) {
            rotate([0,0,i*120-tooth_width/2])
            rotate_extrude(angle=tooth_width)
            polygon( points=[[part_inner_rad, inner_height-inner_thickness],
                [part_inner_rad+tooth_depth+clearance, tooth_height],
                [part_inner_rad+tooth_depth+clearance, 0-clearance ],
                [part_inner_rad, 0-clearance]] );
        }


        rotate_extrude()
            translate([inner_bearing_groove_rad, bearing_groove_depth+inner_height-inner_thickness-bearing_groove_dim/2, 0])
            circle(d=bearing_groove_dim);
    }
}

// inner_params = [inner_rad, inner_wall, inner_thickness, inner_height, tooth_params, bearing_grooves, clearances];
inner_params = [90, 12, 4, 15, [3, 8, 6.5], [14, 1, 60, 90], [1, 5]];
jogwheel_inner(inner_params);
