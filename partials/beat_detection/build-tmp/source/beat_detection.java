import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class beat_detection extends PApplet {

/**
  * This sketch demonstrates how to use the BeatDetect object song SOUND_ENERGY mode.<br />
  * You must call <code>detect</code> every frame and then you can use <code>isOnset</code>
  * to track the beat of the music.
  * <p>
  * This sketch plays an entire song, so it may be a little slow to load.
  * <p>
  * For more information about Minim and additional features, 
  * visit http://code.compartmental.net/minim/
  */
  



Minim minim;
AudioPlayer song;
BeatDetect beat;
AudioInput input;

float eRadius;

public void setup()
{
  
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, PApplet.parseInt(8192));
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  
  ellipseMode(RADIUS);
  eRadius = 60;
}

public void draw()
{
  background(0);
  //beat.detect(song.mix);
  beat.detect(input.mix);
  
  fill(0);
  if ( beat.isOnset() ) fill(255);
  ellipse(width/2, height/2, eRadius, eRadius);
  
  
}
  public void settings() {  size(200, 200, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "beat_detection" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
