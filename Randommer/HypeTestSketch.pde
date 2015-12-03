public class HypeTestSketch extends SketchBase
{
  HDrawablePool pool;

  public HypeTestSketch(PApplet parent, PGraphics canvas) {
    super("HypeTestSketch", parent, canvas);
  }

  @Override
  public void init() {
    H.init(this.parent).background(#202020);
    smooth();

    pool = new HDrawablePool(576);
    pool.autoAddToStage()
      .add (
        new HRect()
        .rounding(4)
      )

      .layout (
        new HGridLayout()
        .startX(21)
        .startY(21)
        .spacing(26,26)
        .cols(24)
      )

      .onCreate (
         new HCallback() {
          public void run(Object obj) {
            HDrawable d = (HDrawable) obj;
            d
              .noStroke()
              .fill( #ECECEC )
              .anchorAt(H.CENTER)
              .size( 25 )
            ;
          }
        }
      )

      .requestAll()
    ;
  }

  @Override
  public void draw() {
    H.drawStage();
  }
}