module ring(ID, OD, width) {
    difference() {
		cylinder(r=OD/2, h=width);
        translate([0,0,-1])
		cylinder(r=ID/2, h=width+2);
	}
}
