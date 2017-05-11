import controlP5.*;

Simulation s;
Graphics g;
ControlP5 cp5;
Robot r;

boolean turningr;
boolean turningl;

void setup() {
  cp5 = new ControlP5(this);
  s = new Simulation();

  size(1280, 1024, P2D);
  g = new Graphics();
  
  //Robot initialization
  PVector start = new PVector(width/2, height/2, 0);
  r = new Robot(start, 30, 40);
  turningl = false;
  turningr = false;
}

void draw() {
  background(170);
  //shape(f.getShape(), 0, 0);
  g.draw1();
  //draw robot
  s.updateBalls();
  s.drawBalls();
  g.draw2();
  
  //s.drawNormals();
  
  
  
  //g.draw();
  
  //shape(f.getShape(), 0, 0);
  r.update();
  r.drawRobot();
}

void mouseClicked(){
  println("X: " + mouseX + ", Y: " + mouseY);
}

void keyPressed(){
 if(key == '1'){
  s.dumpHopperUL(); 
 } else if(key == 'r' || key == 'R'){
   s.resetFuel();
 } else if(key == '2'){
  s.dumpHopperUR();
 }else if(key == '3'){
  s.dumpHopperLL();
 }else if(key == '4'){
  s.dumpHopperLM();
 }else if(key == '5'){
  s.dumpHopperLR();
 }
 
 r.keyPressHandler();
}

void keyReleased(){
  r.keyReleaseHandler();
}