// some defaults for testing
ID = 5;
OD = 10;
width = 5;



module ring(ID, OD, width) {
    difference() {
	    cylinder(r=OD/2, h=width, center=true);
	    cylinder(r=ID/2, h=width+2, center=true);
	}
}

ring(ID, OD, width);
