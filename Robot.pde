class Robot {
  PVector pos;
  PVector vel;
  PVector acc;
  float angle;

  // int max_speed;

  int wide;
  int high;
  int balls;
  boolean gear;

  boolean firing;

  //Health

  Robot(PVector p, int w, int h) {
    pos = p;
    wide = w;
    high = h;
    balls = 100;
    angle = 0;
    acc = new PVector(0, 0, 0);
    vel = new PVector(0, 0, 0);
  }

  void update() {
    //vel.add(acc);
    vel.mult(1.15);

    vel.limit(MAX_SPEED);

    if (turningl) {
      rotateVel(-TURNING_RADIUS);
    }
    if (turningr) {
      rotateVel(TURNING_RADIUS);
    }

    if (firing && balls > 0) {
      s.addBall(new PVector(pos.x, pos.y), PVector.fromAngle(angle).add(vel).setMag(300));
      balls--;
    }
    pos.add(vel);
  }

  void addAngle(float r) {
    angle += r;
    vel.rotate(r);
  }

  void rotateVel(float a) {
    PVector p = new PVector(vel.x, vel.y).rotate(a);
    vel = new PVector(p.x, p.y, 0);
    angle += a;
  }

  void keyPressHandler() {

    if (key == 'w' || keyCode == UP) {
      if (vel.mag() == 0) {
        PVector p = new PVector(5, 0).rotate(r.angle);
        vel = new PVector(p.x, p.y, 0);
      }
    }
    if (key == 's' || keyCode == DOWN) {
      if (vel.mag() == 0) {
        PVector p = new PVector(-5, 0).rotate(r.angle);
        vel = new PVector(p.x, p.y, 0);
      }
    }
    if (key == 'a' || keyCode == LEFT) {
      turningl = true;
    }
    if (key== 'd' || keyCode == RIGHT) {
      turningr = true;
    }

    if (key == ' ') {
      firing = true;
    }
  }

  void keyReleaseHandler() {
    if (key == 'w' || key == 's' || keyCode == UP || keyCode == DOWN) {
      vel = new PVector(0, 0, 0);
    }
    if (key == 'a' || keyCode == LEFT) {
      turningl = false;
      ;
    }
    if (key == 'd' || keyCode == RIGHT) {
      turningr = false;
    }

    if (key == ' ') {
      firing = false;
    }
  }
  void drawRobot() {
    fill(255);
    stroke(140);
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(angle);
    rect(0, 0, high, wide);
    rotate(-angle);
    translate(-pos.x, -pos.y);
  }
}