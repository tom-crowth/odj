jogwheel_outer_rad = 125;
jogwheel_inner_rad = 90;
jogwheel_height = 35;
thickness = 3;

// vertical datum is at bottom of this part
// centred on z-axis

module jogwheel_outer(outer_params){
    
    outer_rad = outer_params[0];
    outer_inside_rad = outer_params[1];
    jogwheel_height = outer_params[2];
    thickness = outer_params[3];
    bearing_params = outer_params[4];
    tooth_params = outer_params[5];
    bearing_grooves = outer_params[6];
    clearances = outer_params[7];

    outer_bear_rad_offset = bearing_params[0];
    outer_bear_vert_offset = bearing_params[1];
    bearing_dims = bearing_params[4];
    bearing_OD = bearing_dims[1];

    tooth_depth = tooth_params[0];
    tooth_height = tooth_params[1];
    tooth_width = tooth_params[2];

    bearing_groove_dim = bearing_grooves[0];
    bearing_groove_depth = bearing_grooves[1];
    outer_bearing_groove_rad = bearing_grooves[3];

    clearance = clearances[0];

    // not used, here for ref for asm:
    // bearing_centre = jogwheel_inner_rad + 7.5; 
    bearing_rest_height = bearing_OD/2 + 8.5;
    mating_slot_width = tooth_width - 2*clearance; // this is an angle
    mating_slot_clearance = 1; // just used to give overlap for the union of slots

    //color("black")
    difference() {
        union() {
            
            // main shape, swept polygon
            // dimensions worked out for a 45 degree angle
            rotate_extrude()
            polygon( points=[[outer_inside_rad, jogwheel_height],
                [outer_rad, 0],
                [outer_rad-thickness, 0],
                [outer_rad - thickness - bearing_rest_height, bearing_rest_height],
                [outer_inside_rad + thickness, bearing_rest_height],
                [outer_inside_rad + thickness, jogwheel_height - 2*thickness],
                [outer_inside_rad, jogwheel_height - thickness]] );

            // mating slots to match jogwheel_inner
            mating_slot_start = outer_inside_rad + thickness + mating_slot_clearance;

            for ( i = [0 : 2] ) {
                rotate([0,0,i*120 - mating_slot_width/2])
                rotate_extrude(angle=mating_slot_width)
                polygon( points=[[outer_inside_rad, jogwheel_height - thickness + mating_slot_clearance],
                    [mating_slot_start, jogwheel_height - 2*thickness],
                    [mating_slot_start, bearing_rest_height],
                    [outer_inside_rad, bearing_rest_height]] );
            }
            
        }

        rotate_extrude()
            translate([outer_bearing_groove_rad, bearing_rest_height+bearing_groove_depth-bearing_groove_dim/2, 0])
            circle(d=bearing_groove_dim);
}

}
difference() {

// outer_params = [outer_rad, inside_rad, jogwheel_height, thickness, bearing_params, tooth_params, clearances];
outer_params = [125, 90, 35, 3, [91, 14.5, 1, 1, [5,23,7], 21], [3,8,6.5], [14, 1, 60, 97], [1,5]];
jogwheel_outer(outer_params);

// optional section
// translate([-150,-300,-75])  
// cube(300);

}
