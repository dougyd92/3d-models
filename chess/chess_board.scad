
SQUARE_WIDTH = 25.4;
BORDER_WIDTH = 6;
BOARD_THICKNESS = 4;

module alternating_squares() {
    difference() { 
        cube([8*SQUARE_WIDTH, 8*SQUARE_WIDTH, BOARD_THICKNESS/2]);
        for(i = [0:7]) {
            for(j = [i%2 : 2 : 7]) {
                translate([i*SQUARE_WIDTH, j*SQUARE_WIDTH, 0]) cube([SQUARE_WIDTH, SQUARE_WIDTH, BOARD_THICKNESS]);
            }
        }
    };
}

module border() {
    CubePoints = [
      [  -BORDER_WIDTH,  -BORDER_WIDTH,  0 ],  //0
      [ BORDER_WIDTH+8*SQUARE_WIDTH,  -BORDER_WIDTH,  0 ],  //1
      [ BORDER_WIDTH+8*SQUARE_WIDTH,  BORDER_WIDTH+8*SQUARE_WIDTH,  0 ],  //2
      [  -BORDER_WIDTH,  BORDER_WIDTH+8*SQUARE_WIDTH,  0 ],  //3
      [  0,  0,  BOARD_THICKNESS ],  //4
      [ 8*SQUARE_WIDTH,  0,  BOARD_THICKNESS ],  //5
      [ 8*SQUARE_WIDTH,  8*SQUARE_WIDTH,  BOARD_THICKNESS ],  //6
      [  0,  8*SQUARE_WIDTH,  BOARD_THICKNESS ]]; //7
      
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left
      
    polyhedron( CubePoints, CubeFaces );
}

difference() {
    border();
    translate([0,0,BOARD_THICKNESS/2]) alternating_squares();
}