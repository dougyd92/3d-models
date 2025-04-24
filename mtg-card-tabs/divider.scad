$fn = 36;

main_symbol_filepath = "C:/Users/dougl/Documents/Downloads/mana-master/mana-master/svg/w.svg";
type_symbol_filepath = "C:/Users/dougl/Documents/Downloads/mana-master/mana-master/svg/instant.svg";


frame_width = 68;
frame_height = 85;
tab_height = 10;
thickness = 1.0;
bevel = 2;
border = 5;
background_thickness = 0.4;
main_symbol_size = 50;
main_symbol_thickness_buffer = 0.2;


module RoundRect(width, depth, height, radius) {
    translate([radius, 0, 0])
        cube([width - 2 * radius, depth, height]);
    
    translate([0, radius, 0])
        cube([width, depth - 2 * radius, height]);
        
    translate([radius, radius, 0])
        cylinder(height, radius, radius);
        
    translate([width - radius, radius, 0])
        cylinder(height, radius, radius);
        
    translate([radius, depth - radius, 0])
        cylinder(height, radius, radius);
        
    translate([width - radius, depth - radius, 0])
        cylinder(height, radius, radius);
}

module InnerCorner(height, radius) {

    translate([radius, radius, 0])
    rotate([180, 180, 0])

    difference() {
        cube([radius, radius, height]);
        cylinder(height, radius, radius);
    }
}

module CardAndTabBlank(frame_width, frame_height, tab_height , thickness, bevel) {
    RoundRect(frame_width, frame_height, thickness, bevel);

    // tab
    translate([0,frame_height - 2 * bevel,0])
        RoundRect(frame_width / 2, tab_height + 2 * bevel, thickness, bevel );
    translate([frame_width / 2, frame_height, 0]) 
        InnerCorner(thickness, bevel / 2);
}

module BlankWithBevel() {
    difference()
    {
        CardAndTabBlank(frame_width, frame_height, tab_height , thickness, bevel);

        translate([border, border, background_thickness ]) 
        RoundRect(frame_width - 2 * border, frame_height - 2 *border, thickness, bevel / 2);
    }
}

module MainSymbol() {
    translate([(frame_width - main_symbol_size) / 2, (frame_height - main_symbol_size) / 2,0])
    resize([main_symbol_size , main_symbol_size , thickness - main_symbol_thickness_buffer])
    linear_extrude(height = thickness)    
        offset(r=0.01) import(main_symbol_filepath);
}

module TypeSymbol() {
    translate([border, frame_height - border / 2, 0])
    linear_extrude(height = thickness)    
    import(type_symbol_filepath);
}

module CardDivider() {
    difference() {
        BlankWithBevel();
        #TypeSymbol();
    }
    
    MainSymbol();
    
}


CardDivider();