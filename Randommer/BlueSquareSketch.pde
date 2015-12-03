public class BlueSquareSketch extends SketchBase
{
  private PVector p;

  public BlueSquareSketch(PApplet parent, PGraphics canvas) {
    super("BlueSquareSketch", parent, canvas);
  }

  @Override
  public void init() {
    p = new PVector(canvas.width / 2, canvas.height / 2, 0);
  }

  @Override
  public void draw() {
    canvas.background(255);
    canvas.stroke(0,0,255);
    canvas.fill(255);
    canvas.rect(p.x, p.y, 50, 50);
  }
}