$fn = 90;

BOWL_R = 10;
BOWL_H = 25;

RING_R = 3;
RING_H = 2;

STEM_R = 2;
STEM_H = 8;

BASE_R_TOP = 2.5;
BASE_R_BOT = 6;
BASE_H = 7;

CONCAVE_SMOOTHING = 1.5;
CONVEX_SMOOTHING = 0.5;

FOO = 15;
BAR = 2;

TOTAL_H = BOWL_H + STEM_H + BASE_H;

module trophy_base() {
    difference() {
        cube(FOO);
        translate([0.75, BAR-1, 0]) 
            rotate([90, 0, 0]) 
            linear_extrude(BAR) 
            import("pro-codecademy-icon-48x48px.svg");
        translate([FOO, 1, FOO/2+4])
            rotate([90, 0, 90])
            linear_extrude(BAR)  
            text("New Horizons", font = "Liberation Sans", size=1.5);
        translate([FOO, 1, FOO/2+1])
            rotate([90, 0, 90]) 
            linear_extrude(BAR)  
            text("Project Name", font = "Liberation Sans", size=1.5);
        translate([FOO, 1, FOO/2-2])
            rotate([90, 0, 90]) 
            linear_extrude(BAR)  
            text("TeamMember1", font = "Liberation Sans", size=1.5);
        translate([FOO, 1, FOO/2-4])
            rotate([90, 0, 90]) 
            linear_extrude(BAR)  
            text("TeamMember2", font = "Liberation Sans", size=1.5);
        translate([FOO, 1, FOO/2-6])
            rotate([90, 0, 90]) 
            linear_extrude(BAR)  
            text("TeamMember3", font = "Liberation Sans", size=1.5);        
    }
    

}  

module half_circle(r) {
    difference() {
        circle(r);
        translate([-r,0]) square(size = 2*r);
    }
}

module cup_base(r_top, r_bot, h) {
    difference() {
        translate([-r_bot, -h]) square([2*r_bot, h]);
        translate([-r_bot - r_top, 0]) resize([0, 2*h]) circle(r_bot);
        translate([r_bot + r_top, 0]) resize([0, 2*h]) circle(r_bot);
    }
}

module profile() {
    offset(r = -CONCAVE_SMOOTHING) offset(r = CONCAVE_SMOOTHING)
    offset(r = CONVEX_SMOOTHING) offset(r = -CONVEX_SMOOTHING)
    { 
        resize([0,BOWL_H,0]) half_circle(BOWL_R);
        translate([-RING_R, -BOWL_H - RING_H/3]) square([2*RING_R,RING_H]);
        translate([-STEM_R, -BOWL_H - STEM_H]) square([2*STEM_R,STEM_H]);
        translate([0, -BOWL_H - STEM_H]) cup_base(BASE_R_TOP, BASE_R_BOT, BASE_H);
    }

}

module left_half() {
    intersection() {
        translate([-1000, -500]) square([1000, 1000]);    
        children();
    }
}


//translate([0, 0, TOTAL_H]) rotate_extrude() left_half() profile();

//translate([-FOO/2, -FOO/2, -FOO+0.25]) trophy_base();

trophy_base();
  