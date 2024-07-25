

use <../jogwheel_assembly.scad>;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 3 : 0.5;

module sectionview() {

    difference() {
        jogwheel_assembly();
        // the item used to vertically section the assembly, move to section differently
        // rotate([0,0,90*$t])
        // translate([-150,-300,-75])  
        // cube(300);

        // for horizontal sectioning
        height = 150 + abs(50*(1 - 2*$t));
        translate([0, 0, height])
            cube(300, center=true);
    }
}

sectionview();
