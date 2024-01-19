include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\Jogwheel inner.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\Jogwheel outer.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\spring.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\bearing.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\jogwheel mid.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\Jogwheel bottom.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\Pressure sensor.scad>
include <C:\Users\tomcr\OneDrive\Documents\OpenSCAD Files\ODJ\Jogwheel subassembly\Retaining ring.scad>


$fn=25; 

difference() {

union() {
    translate([0,0,jogwheel_height]) jogwheel_inner();

    jogwheel_outer();

    translate([0,0,2]) 
    jogwheel_mid();

    translate([0,0,-8]) 
    jogwheel_bottom();

    translate([0,0,-5])
    retaining_ring();

    //bearings
    for (j = [0:2]) {
        for (i = [0:1]) {
            rotate([0,0,i*60+j*120])
            translate([jogwheel_inner_rad-32.5+i*36.5,0,19.5-11*i])
            rotate([0,90,0])
            bearing(5,23,7);
        }
    }

    //springs 
    for (i = [0:2]) {
        rotate([0,0,120*i+60])
        translate([55,0,-1])
        spring(6,8,20,0.8);
    }

    //pressure sensors
    for (i = [0:2]) {
        rotate([0,0,120*i])
        translate([60,0,1])
        pressure_sensor();
    }

}

translate([-150,-300,-75])  
cube(300);

}