use <../utility/ring.scad>

function create_bearing_dims(bearing_ID, bearing_OD, bearing_width) = [bearing_ID, bearing_OD, bearing_width];

module bearing(bearing_dims) {

	bearing_ID = bearing_dims[0];
	bearing_OD = bearing_dims[1];
	bearing_width = bearing_dims[2];

	color("white")
	ring(bearing_ID, bearing_OD, bearing_width);
}

bearing_dims = create_bearing_dims(5, 23, 7);
bearing(bearing_dims);
