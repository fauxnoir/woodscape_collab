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
  
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
AudioInput input;

float eRadius;

void setup()
{
  size(200, 200, P3D);
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, int(8192));
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  
  ellipseMode(RADIUS);
  eRadius = 60;
}

void draw()
{
  background(0);
  //beat.detect(song.mix);
  beat.detect(input.mix);
  
  fill(0);
  if ( beat.isOnset() ) fill(255);
  ellipse(width/2, height/2, eRadius, eRadius);
  
  
}