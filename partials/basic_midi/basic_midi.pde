import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
float rSize;  // rectangle size
float a = 0.0;

void setup() {
  rSize = width / 6;
  size(640, 360, P3D);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  myBus = new MidiBus(this, "Traktor Kontrol Z1 Input", "Traktor Kontrol Z1 Output"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
  //myBus = new MidiBus(this, "User Port", "User Port");
  //myBus = new MidiBus(this, "MIDI input port 0", "MIDI output port 0");
  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  //myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  // A M'FING RECTANGLE 
  //clear bg
  //background(0, 50);
  fill(255);
  
  //a += 0.005;
  //if(a > TWO_PI) { 
    //a = 0.0; 
  //}
  
  translate(width/2, height/2);
  
  rotateX(a * 1.001);
  rotateY(a * 2.002);
  
  //rect( -rSize, -rSize, rSize*2, rSize*2);
  box(100);
  
  // MIDI STUFF GOES HERE
  int channel = 0;
  int pitch = 64;
  int velocity = 127;

  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff

  int number = 0;
  int value = 90;
  myBus.sendControllerChange(channel, number, value); // Send a controllerChange
  
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  
  if( number == 0 ) {
    println( ( (float)value / 127 ) * 2*PI );
    a = ( (float)value / 127 ) * 2*PI ; 
  }
}