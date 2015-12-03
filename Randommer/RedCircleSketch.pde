public class RedCircleSketch extends SketchBase
{
  private PVector p;

  public RedCircleSketch(PApplet parent, PGraphics canvas) {
    super("RedCircleSketch", parent, canvas);
  }

  @Override
  public void init() {
    p = new PVector(canvas.width / 2, canvas.height / 2, 0);
  }

  @Override
  public void draw() {
    canvas.noStroke();
    canvas.background(255);
    canvas.fill(255,0,0);
    canvas.ellipse(p.x, p.y, 50, 50);
  }
}