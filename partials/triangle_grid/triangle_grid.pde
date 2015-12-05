float unitWidth, unitHeight;
int rows, cols;
PImage img;

void setup()
{
  size(1650, 720, P3D);

  img = loadImage(sketchPath("grid.png"));

  // Set unit width
  unitWidth = 101;

  // Set unit height
  unitHeight = 118;

  // Rows and columns are zero-indexed
  rows = 10;
  cols = 15;

}

void draw()
{
  background( img );


  // Draw heel den bazaar
  // fill( 255, 255, 255, 255);
  // for (int i = 0; i < rows + 1; ++i) {
  //   for (int j = 0; j < cols + 1; ++j) {
  //     drawSegment(i,j);
  //   }
  // }

  // Draw some random segments every 200ms
  fill( 0, 0, 0, 255 );
  for (int i = 0; i < rows + 1; ++i) {
    for (int j = 0; j < cols + 1; ++j) {
      float r = random(99);
      if (r > 70) {
        drawSegment(i,j);
      }
    }
  }

  delay(200);

}

Point equilateral( Point one, Point two, float rotation ){
  /**
  * Return the third point given two points of an equilateral trianlge where
  * one = top, two = bottom
  * ... In a motherfucking two dimensional rhombus simplex grid, just like that.
  **/

  Point three = new Point( 0, 0);

  // find offset from point 1 to 2
  float dX = two.x - one.x;
  float dY = two.y - one.y;

  // rotate and add to point 1 to find point 3
  three.x = (cos(rotation) * dX - sin(rotation) * dY) + one.x;
  three.y = (sin(rotation) * dX + cos(rotation) * dY) + one.y;

  return three;
}

void drawSegment( int row, int col){
  Point a = new Point(0,0);
  Point b = new Point(0,0);
  Point c;
  float rotation;

  a.y = (row * unitHeight) / 2;
  b.y = a.y + unitHeight;

  if (col % 2 == 0 ) {
    if (row % 2 == 0) {
      a.x = col * unitWidth;
      b.x = col * unitWidth;
      rotation = radians(-60);
    } else{
      a.x = col * unitWidth + unitWidth;
      b.x = a.x;
      rotation = radians(60);
    }
  }else{
    if (row % 2 == 0) {
      a.x = col * unitWidth + unitWidth;
      b.x = a.x;
      rotation = radians(60);
    } else{
      a.x = col * unitWidth;
      b.x = col * unitWidth;
      rotation = radians(-60);
    }
  }

  c = equilateral( a, b, rotation );

  triangle(a.x, a.y, b.x, b.y, c.x, c.y);
}

class Point {
    float x;
    float y;

    Point(float x1, float y1) {
        x = x1;
        y = y1;
    }
}









