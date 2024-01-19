include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\Utility\Ring.scad>


module jogwheel_mid() {

    difference() {

        
        cylinder(r=70, h=20);        

        union() {
            //cutouts for bearings
            for (i = [0:2]) {
                rotate([0,0,i*120])
                translate([57.5,0,14.5])
                union() {
                    rotate([0,90,0])
                    union() {
                        //cylinder(r=13,h=11);
                        translate([0,0,-5])
                        cylinder(r=2.5,h=21);

                    }
                    translate([0,-13,-20])
                    cube([8,26,30]);
                }
            }

            //cutouts for springs
            for (i = [0:2]) {
                rotate([0,0,60+i*120])
                translate([55,0,-4]) 
                cylinder(r=5,h=18);
            }

            //cutout in centre
            //translate([0,0,-1])
            //cylinder(r=48, h=22);

            translate([0,0,-1])
            linear_extrude(22)
            polygon( points=[[-10,-10],[-10,10],[10,10],[10,-10]]);

        }
    }
    

}

//$fn=500;
//jogwheel_mid(); 