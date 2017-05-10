import controlP5.*;

Field f;
Graphics g;
ControlP5 cp5;

void setup() {
  cp5 = new ControlP5(this);

  size(1280, 1024, P2D);
  f = new Field();
  g = new Graphics();
}

void draw() {
  background(170);
  //shape(f.getShape(), 0, 0);
  g.draw1();
  //draw robot
  g.draw2();
  
  //g.draw();
  
  //shape(f.getShape(), 0, 0);
}

void mouseClicked(){
  println("X: " + mouseX + ", Y: " + mouseY);
}