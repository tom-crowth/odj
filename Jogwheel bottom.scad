module jogwheel_bottom() {

    //color("blue")
    difference() {

        union() {
            cylinder(r=130,h=3);

            //ring at jogwheel outer
            difference() {
                cylinder(r=125,h=7.5);
                translate([0,0,-1])
                cylinder(r=118,h=12);
            }

            //bearing retainers
            for(i = [0:2]) {
                rotate([0,0,30+120*i])
                translate([88,0,0])
                rotate([0,90,0])
                difference(){
                    union(){
                        translate([0,0,15])
                        cylinder(r1=25,r2=15,h=10);
                        cylinder(r=25,h=15);

                    }
                    translate([-1,-30,-5])
                    cube([60,60,60]);
                }
            }

            //spring retainers
            for(i = [0:2]) {
                rotate([0,0,60+120*i])
                translate([55,0,0]){
                
                    cylinder(r=2,h=23);
                    cylinder(r=12,h=7);
                    }
            }

            //sensor pads
            for(i = [0:2]) {
                rotate([0,0,120*i])
                translate([60,0,0])
                cylinder(r=12,h=9);
            }

        }

        //cutouts for bearings
        for (i = [0:2]) {
                    rotate([0,0,i*120+60])
                    translate([92,0,16.5])
                    union() {
                        rotate([0,90,0])
                        union() {
                            cylinder(r=13,h=11);
                            translate([0,0,-5])
                            cylinder(r=2.5,h=21);
                        }
                        translate([0,-13,0])
                        cube([11,26,20]);
                    }
                }

    }
}
//jogwheel_bottom();