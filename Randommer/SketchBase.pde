public class SketchBase
{
  public String name;
  protected PApplet parent;
  protected PGraphics canvas;

  public SketchBase(String name, PApplet parent, PGraphics canvas) {
    this.name = name;
    this.parent = parent;
    this.canvas = canvas;
  }

  public void init() {};

  public void draw() {};
}