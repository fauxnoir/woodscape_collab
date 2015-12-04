
// imports
import codeanticode.syphon.*;
import themidibus.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

// configuration
final int WIDTH = 1280;
final int HEIGHT = 720;
final int MIDI_BUS_ID = 1;

// syphon
PGraphics canvas;
SyphonServer server;

// midi
MidiBus midiBus;

// line input & beat detection
Minim minim;
AudioInput audioInput;
BeatDetect beatDetect;
BeatListener beatListener;

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

  // set active midi device
  midiBus = new MidiBus(this, MIDI_BUS_ID, "");

  // line in & beat detection
  minim = new Minim(this);
  audioInput = minim.getLineIn(Minim.STEREO, int(2048), int(44100));
  beatDetect = new BeatDetect( int(2048), int(44100) );
  beatDetect.setSensitivity(10);
  beatListener = new BeatListener(beatDetect, audioInput);

  // creating a list of our sketches
  sketches = new ArrayList<SketchBase>();
  sketches.add(new RedCircleSketch(this, canvas));
  sketches.add(new BlueSquareSketch(this, canvas));
  sketches.add(new StripesSketch(this, canvas));

  // calling the initialization function on each sketch in the list
  for(SketchBase s : sketches) {
    s.init();
  }

  // set selected sketch to first one
  selected = 0;

  // set smoothing
  smooth();
}

// draw loop
void draw() {

  // draw the active sketch
  canvas.beginDraw();
  sketches.get(selected).draw(beatDetect);
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
  // if(number == 47)
    // selected = (selected + 1) % sketches.size();

  // 46: push controller, arrow up
  // if(number == 46)
    // selected = selected == 0 ? sketches.size() - 1 : (selected - 1) % sketches.size();

  // traktor z1 crossfader
  if(channel == 2 && number == 5) {
    float normalizedValue = (float)value / 127.0;
    float mappedValue = normalizedValue * 500.0;
    println("mapped: " + mappedValue);
    beatDetect.setSensitivity((int)mappedValue);
  }

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
  if(key == '3') {
    selected = 3;
  }

  println(sketches.get(selected).name);
}





// example how to create an extra window
//
// import g4p_controls.*;
// GWindow renderWindow;
// renderWindow = GWindow.getWindow(this, "Resizeable 3D window", 0, 0, 240, 180, P3D);