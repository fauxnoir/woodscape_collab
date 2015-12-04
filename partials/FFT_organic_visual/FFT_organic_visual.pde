import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
int radius = 200;
float[] spectrum = new float[bands];
SoundFile file;
  float lastX = 0;
  float lastY = 0;

void setup() {
  size(800, 800);
  smooth(4);
  noStroke();
  background(0);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  file = new SoundFile(this, "/Users/matthias/Documents/Processing/woodscape_collab/partials/FFT_organic_visual/track.mp3");
  
  // start the Audio Input
  file.play();
  
  // patch the AudioIn
  fft.input(file);
}      

void draw() { 
  fill(0,10);
  rect(0,0,width,height);
  fft.analyze(spectrum);
  int interpolateCount = 4;
  float dAngle = (float) bands / 45;
  float angle = 0;
  
 

  for(int i = 0; i < bands / 16; i++){
    
    float dRadius = 60 + spectrum[i]*200;
    float nextRadius = 60 + spectrum[i + 1]*200;
    float diffRadius = (nextRadius - dRadius) / (interpolateCount + 1);
    
    for(int u = 0; u < interpolateCount + 1; u++){
      float useR = dRadius + (u * diffRadius);
    
      float x1 = calculateX(useR, angle);
      float y1 = calculateY(useR, angle);
      
      float x2 = calculateX(-useR, angle);
      float y2 = calculateY(-useR, angle);
       
       drawLineFromLastPoint(x1, y1);
       drawPoints(x1, y1, x2, y2);
       angle += (dAngle / (interpolateCount + 1));
    }
  } 
}
float calculateX(float radiusOffset, float angle) {
  return (cos(radians(angle)) * (radius + radiusOffset)) + (width/2);
}
float calculateY(float radiusOffset, float angle) {
  return (sin(radians(angle)) * (radius + radiusOffset)) + (height/2);
}
void drawLineFromLastPoint(float newX, float newY) {
  if(lastX != 0 && lastY != 0) {
       stroke(#FFFFFF, 70);
       line(lastX, lastY, newX, newY);
     }
     lastX = newX;
     lastY = newY;
}
void drawPoints(float x1, float y1, float x2, float y2) {
   noStroke();
     fill(#FFFFFF, 70);
     ellipse(x1, y1, 2, 2);
     fill(#AAAAAA, 90);
     ellipse(x2, y2, 1, 1);
     stroke(#555555, 70);
     line(x1, y1, x2, y2);
}