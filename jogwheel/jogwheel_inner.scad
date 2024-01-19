$fn = 200;

jogwheel_outer_rad = 125;
jogwheel_inner_rad = 90;
jogwheel_height = 35;
thickness = 3;

module jogwheel_inner() {

    difference() {

        rotate_extrude()
        polygon( points=[[0,0],
            [jogwheel_inner_rad-1,0],
            [jogwheel_inner_rad-1,-4],
            [jogwheel_inner_rad+2,-7],
            [jogwheel_inner_rad+2,-15],
            [jogwheel_inner_rad-12,-15],
            [jogwheel_inner_rad-12,-4],
            [0,-4]] );
                
        for ( i = [0 : 2] ) {
            rotate([0,0,i*120-3.25])
            rotate_extrude(angle=6.5)
            polygon( points=[[jogwheel_inner_rad-1,-3],
                [jogwheel_inner_rad+3,-7],
                [jogwheel_inner_rad+3,-16],
                [jogwheel_inner_rad-1,-16]] );
        }
        
    }

}

//$fn=500;
//jogwheel_inner();