module spring(ID, OD, length, dia, revs=5) {
    
    color("grey")
    union(){

        linear_extrude(length, twist=360*revs)
        translate([(OD+ID)/4,0,0])
        circle(dia/2);

        for (i = [0:1]) {
            translate([0,0,i*length])
            rotate_extrude()
            translate([(OD+ID)/4,0,0])
            circle(dia/2);
        }

    }
}
