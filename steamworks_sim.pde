import controlP5.*;

Field f;
Graphics g;


void setup() {
  size(1280, 1024, P2D);
  //f = new Field();
  g = new Graphics();
}

void draw() {
  background(170);
  //shape(f.getShape(), 0, 0);
  g.draw();
}