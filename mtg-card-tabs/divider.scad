$fn = 36;

// Override these from the commandline
main_symbol_filepath = "/Users/douglasdejesus/Downloads/mana-master/svg/b.svg";
type_symbol_filepath = "/Users/douglasdejesus/Downloads/mana-master/svg/instant.svg";
tab_side = 1;

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

module CardAndTabBlank(frame_width, frame_height, tab_height , thickness, bevel, tab_side) {
    RoundRect(frame_width, frame_height, thickness, bevel);

    // tab
    translate(tab_side == 1 ? 
          [frame_width / 2, frame_height - 2 * bevel,0]
        : [0, frame_height - 2 * bevel, 0]
    
    )
    RoundRect(frame_width / 2, tab_height + 2 * bevel, thickness, bevel );
    

    translate([frame_width / 2, frame_height, tab_side == 1 ? thickness : 0]) 
        rotate([0,tab_side == 1 ? 180 : 0,0])
    InnerCorner(thickness, bevel / 2);
}

module BlankWithBevel() {
    difference()
    {
        CardAndTabBlank(frame_width, frame_height, tab_height , thickness, bevel, tab_side);

        translate([border, border, background_thickness ]) 
        RoundRect(frame_width - 2 * border, frame_height - 2 *border, thickness, bevel / 2);
    }
}

module MainSymbol() {
    translate([(frame_width - main_symbol_size) / 2, (frame_height - main_symbol_size) / 2,0])
    linear_extrude(height = thickness - main_symbol_thickness_buffer)
    resize([0, main_symbol_size, 0], auto=true)
    offset(r = 0.01)
    import(main_symbol_filepath);
}

module TypeSymbol() {
    translate([tab_side == 1 ? frame_width - 3 * border : border, 
        frame_height - border / 2, 0])
    #linear_extrude(height = thickness)    
    import(type_symbol_filepath);
}

module CardDivider() {
    difference() {
        BlankWithBevel();
        TypeSymbol();
    }
    
    MainSymbol();
    
}


CardDivider();