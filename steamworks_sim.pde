import controlP5.*;

Simulation s;
Graphics g;
ControlP5 cp5;
Robot r;

boolean turningr;
boolean turningl;
boolean tips;

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
  tips = true;
}

void draw() {
  background(170);
  //shape(f.getShape(), 0, 0);
  g.draw1();
  //draw robot
  s.updateBalls();


  r.update();

  //s.drawNormals();

  if (!s.hopperUL) {
    fill(fuelColor);
    stroke(fuelColor);
    rectMode(CORNERS);
    rect(377, 11, 408, 41);
    rect(470, 11, 503, 41);
  }

  if (!s.hopperUR) {
    fill(fuelColor);
    stroke(fuelColor);
    rectMode(CORNERS);
    rect(776, 11, 808, 41);
    rect(870, 11, 900, 41);
  }

  if (!s.hopperLL) {
    fill(fuelColor);
    stroke(fuelColor);
    rectMode(CORNERS);
    rect(232, 600, 265, 630);
    rect(326, 600, 358, 630);
  }

  if (!s.hopperLM) {
    fill(fuelColor);
    stroke(fuelColor);
    rectMode(CORNERS);
    rect(578, 600, 609, 630);
    rect(672, 600, 702, 630);
  }

  if (!s.hopperLR) {
    fill(fuelColor);
    stroke(fuelColor);
    rectMode(CORNERS);
    rect(922, 600, 951, 630);
    rect(1014, 600, 1045, 630);
  }

  //g.draw();

  //shape(f.getShape(), 0, 0);
  r.drawRobot();
  s.drawBalls();
  g.draw2();
  //s.drawNormals2();

  g.robotDetails(900, 850, r);
  if (tips) {
    g.drawTips();
  }
}

void mouseClicked() {
  println("X: " + mouseX + ", Y: " + mouseY);
}

void keyPressed() {
  if (key == '1') {
    s.dumpHopperUL();
  } else if (key == 'r' || key == 'R') {
    s.resetFuel();
    r.balls = 100;
  } else if (key == '2') {
    s.dumpHopperUR();
  } else if (key == '3') {
    s.dumpHopperLL();
  } else if (key == '4') {
    s.dumpHopperLM();
  } else if (key == '5') {
    s.dumpHopperLR();
  }

  if (key == 't') {
    tips = !tips;
  }
  r.keyPressHandler();
}

void keyReleased() {
  r.keyReleaseHandler();
}