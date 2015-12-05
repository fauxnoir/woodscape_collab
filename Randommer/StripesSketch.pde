public class StripesSketch extends SketchBase
{
  private PVector p;

  public StripesSketch(PApplet parent, PGraphics canvas) {
    super("StripesSketch", parent, canvas);
  }

  @Override
  public void init() {

  }

  @Override
  public void draw(BeatDetect beatDetect) {
    canvas.noStroke();
    canvas.background(0);

    // draw a green rectangle for every detect band
    // that had an onset this frame
    float rectW = canvas.width / beatDetect.detectSize();
    for(int i = 0; i < beatDetect.detectSize(); ++i) {
      // test one frequency band for an onset
      if(beatDetect.isOnset(i)) {
        canvas.fill(255);
        canvas.rect(i * rectW, 0, rectW, canvas.height);
      }
    }

    canvas.fill(255);
  }
}