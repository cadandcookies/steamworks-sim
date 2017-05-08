import controlP5.*;

Field f;

void setup() {
  size(1280, 1024, P2D);
  f = new Field();
}

void draw() {
  background(170);
  shape(f.getShape(), 0, 0);
}