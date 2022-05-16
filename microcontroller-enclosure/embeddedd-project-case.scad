BOARD_WIDTH = 66.6;
BOARD_LENGTH = 122;
SENSOR_BUMP_LENGTH = 24;
TOTAL_LENGTH = BOARD_LENGTH + SENSOR_BUMP_LENGTH;

BOTTOM_CLEARANCE = 20;
TOP_CLEARANCE = 11;

WALL_HEIGHT = BOTTOM_CLEARANCE + TOP_CLEARANCE;
WALL_THICKNESS = 1.6;

POST_SIZE = 4.8;

USB_HOLE_WIDTH = 9;
USB_HOLE_HEIGHT = 4.3;
USB_HOLE_VERTICAL_OFFSET = 2;

SENSOR_WIDTH = 44;
SENSOR_THICKNESS = 2.4;
SENSOR_POST_HEIGHT = 18;
SENSOR_CLEARANCE = 1.6;

TUBE_WIDTH = 6;
TUBE_VERTICAL_OFFSET = 8;

LCD_WIDTH = 43;
LCD_HEIGHT = 58;
LCD_X_OFFSET = 7;

BUTTON_X_OFFSET = 79; //80
BUTTON_DIAMETER = 6;
BUTTON_SPACING = 20; //20.5

TOLERANCE = 0.2;

module baseboard() {
    union() {
         difference() {
            translate([-SENSOR_BUMP_LENGTH, 0, 0]) cube([TOTAL_LENGTH, BOARD_WIDTH, WALL_THICKNESS]);   
             
            // Cutout for prototyping
            translate([3*POST_SIZE/2, WALL_THICKNESS, -0.1]) 
                cube([BOARD_LENGTH-3*POST_SIZE, 
                      BOARD_WIDTH-2*WALL_THICKNESS, 
                      WALL_THICKNESS+2]);
        } 
    }
}

module walls() {
    union() {
        // Side walls
        SIDE_WALL_LENGTH = TOTAL_LENGTH+2*WALL_THICKNESS;
        SIDE_WALL_X_OFFSET = -WALL_THICKNESS-SENSOR_BUMP_LENGTH;
        translate([SIDE_WALL_X_OFFSET, -WALL_THICKNESS, 0]) 
            cube([SIDE_WALL_LENGTH, WALL_THICKNESS, WALL_HEIGHT]);    
        translate([SIDE_WALL_X_OFFSET, BOARD_WIDTH, 0]) 
            cube([SIDE_WALL_LENGTH, WALL_THICKNESS, WALL_HEIGHT]);    
        
        difference() {
            translate([SIDE_WALL_X_OFFSET, 0, 0]) 
                cube([WALL_THICKNESS,BOARD_WIDTH,WALL_HEIGHT]);
            // Tube cutout
            translate([SIDE_WALL_X_OFFSET, BOARD_WIDTH/2-TUBE_WIDTH/2, TUBE_VERTICAL_OFFSET]) 
                cube([WALL_THICKNESS,TUBE_WIDTH,WALL_HEIGHT]);
        }
        
        difference() {
            translate([BOARD_LENGTH, 0, 0]) 
                cube([WALL_THICKNESS,BOARD_WIDTH,WALL_HEIGHT]);
            // USB cutout
            translate([BOARD_LENGTH, BOARD_WIDTH/2-USB_HOLE_WIDTH/2, BOTTOM_CLEARANCE+USB_HOLE_VERTICAL_OFFSET]) 
                cube([WALL_THICKNESS,USB_HOLE_WIDTH,USB_HOLE_HEIGHT]);
        }
    }
}

module post() {
    cube([POST_SIZE,POST_SIZE,BOTTOM_CLEARANCE]);
}

module posts() {
    union() {
        translate([0, 0, 0]) post();
        translate([0, BOARD_WIDTH-POST_SIZE, 0]) post();
        translate([BOARD_LENGTH-POST_SIZE, BOARD_WIDTH-POST_SIZE, 0]) post();
        translate([BOARD_LENGTH-POST_SIZE, 0, 0]) post();
    }
}

module sensor_posts() {
    SENSOR_POST_OFFSET = (BOARD_WIDTH-POST_SIZE)/2;
       
    difference() {
        union() {
            translate([-WALL_THICKNESS-SENSOR_THICKNESS, SENSOR_POST_OFFSET - SENSOR_WIDTH/2, 0]) cube([2*WALL_THICKNESS+SENSOR_THICKNESS, POST_SIZE, SENSOR_POST_HEIGHT]);
            translate([-WALL_THICKNESS-SENSOR_THICKNESS, SENSOR_POST_OFFSET + SENSOR_WIDTH/2,0]) cube([2*WALL_THICKNESS+SENSOR_THICKNESS, POST_SIZE, SENSOR_POST_HEIGHT]);
        }
    
        translate([-SENSOR_THICKNESS, (BOARD_WIDTH-SENSOR_WIDTH)/2-SENSOR_CLEARANCE, 0]) cube([SENSOR_THICKNESS, SENSOR_WIDTH+2*SENSOR_CLEARANCE, SENSOR_POST_HEIGHT]);
    }
   
    
}


module case_bottom() {
   union() {
    baseboard();
    walls();
    posts();
    sensor_posts();
    }
}


module basic_lid() {
    translate([-SENSOR_BUMP_LENGTH-WALL_THICKNESS, -WALL_THICKNESS, WALL_HEIGHT]) 
        cube([TOTAL_LENGTH+2*WALL_THICKNESS, BOARD_WIDTH+2*WALL_THICKNESS, WALL_THICKNESS]);   
    
    difference() {
        translate([-SENSOR_BUMP_LENGTH+TOLERANCE, TOLERANCE, WALL_HEIGHT-WALL_THICKNESS]) 
            cube([TOTAL_LENGTH-2*TOLERANCE, BOARD_WIDTH-2*TOLERANCE, WALL_THICKNESS]);   
        translate([-SENSOR_BUMP_LENGTH+TOLERANCE+WALL_THICKNESS, TOLERANCE+WALL_THICKNESS, WALL_HEIGHT-WALL_THICKNESS]) 
            cube([TOTAL_LENGTH-2*TOLERANCE-2*WALL_THICKNESS, BOARD_WIDTH-2*TOLERANCE-2*WALL_THICKNESS, WALL_THICKNESS]);   
    }
}

module lid_cutouts() {
    translate([LCD_X_OFFSET, BOARD_WIDTH/2-LCD_WIDTH/2, WALL_HEIGHT-WALL_THICKNESS])
        cube([LCD_HEIGHT, LCD_WIDTH, 2*WALL_THICKNESS]);
    
    translate([BUTTON_X_OFFSET+BUTTON_DIAMETER, BOARD_WIDTH/2+BUTTON_SPACING/2+BUTTON_DIAMETER/2, WALL_HEIGHT-WALL_THICKNESS])
        cylinder(h=2*WALL_THICKNESS, d=BUTTON_DIAMETER);
    
    translate([BUTTON_X_OFFSET+BUTTON_DIAMETER, BOARD_WIDTH/2-BUTTON_SPACING/2-BUTTON_DIAMETER/2, WALL_HEIGHT-WALL_THICKNESS])
        cylinder(h=2*WALL_THICKNESS, d=BUTTON_DIAMETER);
}

module lid() {
        difference() {
            basic_lid();
            lid_cutouts();
        }
}

{
    %case_bottom();
    lid();
}
