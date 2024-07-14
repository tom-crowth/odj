function create_sensor_dims(sensor_OD=18.3, sensor_thick=0.4, tab_length=27-18.3/2, tab_width=6.6) = [sensor_OD, sensor_thick, tab_length, tab_width];

module pressure_sensor(sensor_dims) {

    sensor_OD = sensor_dims[0];
    sensor_thick = sensor_dims[1];
    tab_length = sensor_dims[2];
    tab_width = sensor_dims[3];

    color("red")
    union() {
        cylinder(d=sensor_OD, h=sensor_thick);
        translate([0, -tab_width/2, 0])
        cube([tab_length, tab_width, sensor_thick]);
    }
}

sensor_dims = create_sensor_dims();
pressure_sensor(sensor_dims);
