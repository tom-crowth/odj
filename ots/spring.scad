function create_spring_dims(ID, OD, length, wire_dia=1, revs=5) = [ID, OD, length, wire_dia, revs];

module spring(ID, OD, length, wire_dia, revs=4) {
    
    color("red")
    union(){

        linear_extrude(length, twist=360*revs)
        translate([(OD+ID)/4,0,0])
        circle(wire_dia/2);

        for (i = [0:1]) {
            translate([0,0,i*length])
            rotate_extrude()
            translate([(OD+ID)/4,0,0])
            circle(wire_dia/2);
        }

    }
}
spring(6,8,20,1);
