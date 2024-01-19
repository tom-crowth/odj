//$fn = 200;

jogwheel_outer_rad = 125;
jogwheel_inner_rad = 90;
jogwheel_height = 35;
thickness = 3;

module jogwheel_outer(){

    //color("black")
    union() {

        rotate_extrude()
        polygon( points=[[jogwheel_inner_rad,jogwheel_height],
            [jogwheel_outer_rad,0],
            [jogwheel_outer_rad-thickness,0],
            [102,20],
            [93,20],
            [93,29],
            [90,32]] );
        
        for ( i = [0 : 2] ) {
            rotate([0,0,i*120-2.5])
            rotate_extrude(angle=5)
            polygon( points=[[jogwheel_inner_rad,jogwheel_height-2],
                [93+1,29],
                [93+1,20],
                [jogwheel_inner_rad,20]] );
        }
        
    }

}

//$fn=500;
//jogwheel_outer();