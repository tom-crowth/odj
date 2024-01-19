module pressure_sensor() {

    color("red")
    union() {
        cylinder(r=18.3/2,h=0.4);
        translate([0,-3.3,0])
        cube([27-18.3/2,6.6,0.4]);
    }
}

//pressure_sensor();