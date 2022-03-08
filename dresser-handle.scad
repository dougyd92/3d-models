$fn = $preview ? 36 : 360;


HEIGHT = 14;

ARC_R = 132;
HANDLE_THICKNESS = 10;
HANDLE_WIDTH = 132;

KNOB_R = 8;

OFFSET = 16;

SCREW_R = 2;

module arc() {
    translate([0,HANDLE_THICKNESS - ARC_R,0]) intersection() {
        translate([-HANDLE_WIDTH/2,0,0]) cube([HANDLE_WIDTH,1000,HEIGHT]);
        difference() {
            cylinder(h=HEIGHT, r=ARC_R);
            translate([0,0,-0.1]) cylinder(h=HEIGHT*1.1, r=ARC_R-HANDLE_THICKNESS);
        }
    }
}

module handle() {
    union() {
        translate([HANDLE_WIDTH/2,0,0]) cylinder(h=HEIGHT, r=KNOB_R );
        translate([-HANDLE_WIDTH/2,0,0]) cylinder(h=HEIGHT, r=KNOB_R );
        translate([-HANDLE_WIDTH/2-KNOB_R,-KNOB_R,0]) cube([2*KNOB_R,KNOB_R,HEIGHT]);
        translate([HANDLE_WIDTH/2-KNOB_R,-KNOB_R,0]) cube([2*KNOB_R,KNOB_R,HEIGHT]);
        translate([0,OFFSET,0]) arc();
    }
}

module screw_hole() {
    rotate([90,0,0]) cylinder(h=HEIGHT, r=SCREW_R);
}

difference() {
    handle();
    translate([HANDLE_WIDTH/2,0,HEIGHT/2]) screw_hole();
    translate([-HANDLE_WIDTH/2,0,HEIGHT/2]) screw_hole();
}
