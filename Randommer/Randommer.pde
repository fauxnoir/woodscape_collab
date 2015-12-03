import g4p_controls.*;
import codeanticode.syphon.*;

// syphon
PGraphics canvas;
SyphonServer server;
GWindow renderWindow;

// list of our sketches
ArrayList<SketchBase> sketches;

// index of the selected sketch
int selected;

void settings() {
  size(1280, 720, P3D);
  PJOGL.profile = 1;
}

void setup() {
  // set canvas size and 3d rendering mode
  canvas = createGraphics(1280, 720, P3D);


  renderWindow = GWindow.getWindow(this, "Resizeable 3D window", 0, 0, 240, 180, P3D);

  // create syhpon server to send frames out
  server = new SyphonServer(this, "Processing Syphon");

  // creating a list of our sketches
  sketches = new ArrayList<SketchBase>();
  sketches.add(new RedCircleSketch(this, canvas));
  sketches.add(new BlueSquareSketch(this, canvas));
  sketches.add(new HypeTestSketch(this, canvas));

  // calling the initialization function on each applet in the list
  for(SketchBase s : sketches) {
    s.init();
  }

  selected = 0;
}

void draw() {
  canvas.beginDraw();
  sketches.get(selected).draw();
  canvas.endDraw();

  // send over syphon
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

/**
 * Here we use key presses to determine which
 * app to display.
 **/
void keyPressed() {
  if(key == '0') {
    selected = 0;
  }
  if(key == '1') {
    selected = 1;
  }
  if(key == '2') {
    selected = 2;
  }

  println(sketches.get(selected).name);
}