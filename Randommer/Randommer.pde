
// imports
import codeanticode.syphon.*;
import themidibus.*;

// configuration
final int WIDTH = 1280;
final int HEIGHT = 720;
final int MIDI_BUS_ID = 2;

// syphon
PGraphics canvas;
SyphonServer server;

// midi
MidiBus midiBus;

// list of our sketches
ArrayList<SketchBase> sketches;

// index of the selected sketch
int selected;

// setttings
void settings() {
  size(WIDTH, HEIGHT, P3D);
  PJOGL.profile = 1;
}

// setup sequence
void setup() {

  // set canvas size and 3d rendering mode
  canvas = createGraphics(WIDTH, HEIGHT, P3D);

  // create syhpon server to send frames out
  server = new SyphonServer(this, "Processing Syphon");

  // list midi devices
  MidiBus.list();
  midiBus = new MidiBus(this, MIDI_BUS_ID, "");

  // creating a list of our sketches
  sketches = new ArrayList<SketchBase>();
  sketches.add(new RedCircleSketch(this, canvas));
  sketches.add(new BlueSquareSketch(this, canvas));
  sketches.add(new HypeTestSketch(this, canvas));

  // calling the initialization function on each sketch in the list
  for(SketchBase s : sketches) {
    s.init();
  }

  // set selected sketch to first one
  selected = 0;
}

// draw loop
void draw() {

  // draw the active sketch
  canvas.beginDraw();
  sketches.get(selected).draw();
  canvas.endDraw();

  // send over syphon
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

// midi note received
void noteOn(int channel, int pitch, int velocity) {
  println("channel: " + channel + ", pitch: " + pitch + ", velocity: " + velocity);
}

// midi control message received
void controllerChange(int channel, int number, int value) {
  if(value == 0) return;

  println("channel: " + channel + ", number: " + number + ", value: " + value);

  // 47: push controller, arrow down
  if(number == 47)
    selected = (selected + 1) % sketches.size();

  // 46: push controller, arrow up
  if(number == 46)
    selected = selected == 0 ? sketches.size() - 1 : (selected - 1) % sketches.size();

  println(sketches.get(selected).name);
}

// keyboard key pressed
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





// example how to create an extra window
//
// import g4p_controls.*;
// GWindow renderWindow;
// renderWindow = GWindow.getWindow(this, "Resizeable 3D window", 0, 0, 240, 180, P3D);