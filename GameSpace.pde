class GameSpace {
  private int x;
  private int y;
  private int width;
  private int height;
  private int value;
  
  GameSpace(int nx, int ny, int nw, int nh, int nv) {
    x=nx;
    y=ny;
    width=nw;
    height=nh;
    value=nv;
  }
  
  public void show() {
    stroke(0);
    fill(255);
    rect(x, y, height, width);
    fill(0);
    text(value, x+10, y+60);
    textSize(55);
  }
  
  public void setValue(int v) {
    value = v;
  }
}
