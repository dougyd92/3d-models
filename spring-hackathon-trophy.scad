$fn = $preview ? 36 : 90;

CUP_R = 10;
CUP_H = 24;

RING_R = 3;
RING_H = 1.5;

STEM_R = 2;
STEM_H = 12;

BASE_R_TOP = 2.5;
BASE_R_BOT = 8;
BASE_H = 9;

CONCAVE_SMOOTHING = 2;
CONVEX_SMOOTHING = 0.5;

BOX_SIZE = 20;
INSCRIPTION_DEPTH = 1;

TOTAL_H = CUP_H + STEM_H + BASE_H;

PROJECT_NAME = "PROJECT NAME";
PROJECT_FONT_SIZE = BOX_SIZE*0.07;

PARTICIPANT_1 = "One";
PARTICIPANT_2 = "Two";
PARTICIPANT_3 = "Three";
PARTICIPANT_4 = "Four";
PARTICIPANT_5 = "Five";
PARTICIPANT_6 = "Six";
TOTAL_PARTICIPANTS = 6;
MAX_PARTICIPANTS = 6;
NAMES_FONT_SIZE = BOX_SIZE*0.08;

CATEGORY_1 = "Category 1";
CATEGORY_2 = "Category 2";
CATEGORY_FONT_SIZE = BOX_SIZE*0.06;

HACKATHON_FONT_SIZE = BOX_SIZE*0.08;

module inscribe_right(text, size, pos, spacing) {
    translate([BOX_SIZE - INSCRIPTION_DEPTH/2, BOX_SIZE/2, BOX_SIZE * (spacing + 2 - pos) / (spacing + 3)])
            rotate([90, 0, 90]) 
            linear_extrude(INSCRIPTION_DEPTH)  
            text(text, font = "Liberation Mono", size=size, halign="center", valign="center");
}

module inscribe_left(text, size, pos, spacing) {
    translate([INSCRIPTION_DEPTH/2, BOX_SIZE/2, BOX_SIZE * (spacing + 2 - pos) / (spacing + 3)])
            rotate([90, 0, -90]) 
            linear_extrude(INSCRIPTION_DEPTH)  
            text(text, font = "Liberation Mono", size=size, halign="center", valign="center");
}

module trophy_base() {
    difference() {
        cube(BOX_SIZE);
        translate([BOX_SIZE * 0.05, INSCRIPTION_DEPTH/2, 0]) 
            rotate([90, 0, 0]) 
            resize([BOX_SIZE * 0.9, 0, 0], auto=[true,true,false])
            linear_extrude(INSCRIPTION_DEPTH) 
            import("pro-codecademy-icon-48x48px.svg");
        
        inscribe_right(PROJECT_NAME, PROJECT_FONT_SIZE, 0, MAX_PARTICIPANTS);
        inscribe_right(PARTICIPANT_1, NAMES_FONT_SIZE, 2, TOTAL_PARTICIPANTS);
        inscribe_right(PARTICIPANT_2, NAMES_FONT_SIZE, 3, TOTAL_PARTICIPANTS);
        inscribe_right(PARTICIPANT_3, NAMES_FONT_SIZE, 4, TOTAL_PARTICIPANTS);
        inscribe_right(PARTICIPANT_4, NAMES_FONT_SIZE, 5, TOTAL_PARTICIPANTS);
        inscribe_right(PARTICIPANT_5, NAMES_FONT_SIZE, 6, TOTAL_PARTICIPANTS);
        inscribe_right(PARTICIPANT_6, NAMES_FONT_SIZE, 7, TOTAL_PARTICIPANTS);
           
        inscribe_left("Hackathon", HACKATHON_FONT_SIZE, 0, 4);
        inscribe_left("Spring 2021", HACKATHON_FONT_SIZE, 1, 4);
        if (CATEGORY_2) {
            inscribe_left(CATEGORY_1, CATEGORY_FONT_SIZE, 9, 10);
            inscribe_left("+", CATEGORY_FONT_SIZE, 10, 10);
            inscribe_left(CATEGORY_2, CATEGORY_FONT_SIZE, 11, 10);
        }
        else {
            inscribe_left(CATEGORY_1, CATEGORY_FONT_SIZE, 7, 6);
        }
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
        resize([0,CUP_H,0]) half_circle(CUP_R);
        translate([-RING_R, -CUP_H - RING_H/3]) square([2*RING_R,RING_H]);
        translate([-STEM_R, -CUP_H - STEM_H]) square([2*STEM_R,STEM_H]);
        translate([0, -CUP_H - STEM_H]) cup_base(BASE_R_TOP, BASE_R_BOT, BASE_H);
    }
}

module left_half() {
    intersection() {
        translate([-1000, -500]) square([1000, 1000]);    
        children();
    }
}


translate([0, 0, TOTAL_H]) difference() {
    rotate_extrude() left_half() profile();
    scale([1,1,2]) sphere(r=CUP_R-1);
}


translate([-BOX_SIZE/2, -BOX_SIZE/2, -BOX_SIZE+0.25]) trophy_base();
