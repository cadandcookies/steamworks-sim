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

  ArrayList<CollidableWall> walls;
  //Health

  Robot(PVector p, int w, int h) {
    pos = p;
    wide = w;
    high = h;
    balls = 100;
    angle = 0;
    acc = new PVector(0, 0, 0);
    vel = new PVector(0, 0, 0);
    
    walls = new ArrayList<CollidableWall>();
    walls.add(new CollidableWall(new PVector(pos.x-h/2, pos.y - w/2), new PVector(pos.x - h/2, pos.y + w/2), false));
    walls.add(new CollidableWall(new PVector(pos.x - h/2, pos.y + w/2), new PVector(pos.x + h/2, pos.y + w/2), false));
    walls.add(new CollidableWall(new PVector(pos.x + h/2, pos.y + w/2), new PVector(pos.x + h/2, pos.y - w/2), false));
    walls.add(new CollidableWall(new PVector(pos.x + h/2, pos.y - w/2), new PVector(pos.x - h/2, pos.y - w/2), false));

  }

  void update() {
    //vel.add(acc);
    vel.mult(1.15);

    vel.limit(MAX_SPEED);

    if (turningl) {
      rotateVel(-TURNING_RADIUS);
      rotateWalls(-TURNING_RADIUS);
    }
    if (turningr) {
      rotateVel(TURNING_RADIUS);
      rotateWalls(TURNING_RADIUS);
    }

    if (firing && balls > 0) {
      float randAngle = random(0 - PI/8, PI/8);
      
      s.addFlyingBall(new PVector(pos.x, pos.y), PVector.fromAngle(angle + randAngle).add(vel).setMag(300));
      balls--;
    }
    
       if(collides(walls.get(0), s.airshipLeft)){
     println("colliding");
   }
    pos.add(vel);
    
    for (CollidableWall w: walls){
      w.translate(vel); 
    }
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
      if(firing!= true && balls > 0){
       firing = true; 
      }
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
    drawShapes();
  }
  
  void drawShapes(){
    /*for (CollidableWall w: walls){
      shape(w.getShape(),0,0); 
    }*/
    shape(walls.get(0).getShape());
  }
  
  void rotateWalls(float r){
    for (CollidableWall w: walls){
      w.rotate(pos, r); 
    }
  }
 
 ArrayList<CollidableWall> getWalls(){
   return walls;
 }
 
 boolean collisionField(){
   /*ArrayList<ArrayList<CollidableWall>> l = s.getFieldCollides();
   for (ArrayList<CollidableWall> w: l){
     if(collides(walls, w)){
       println("Collision");
       return true;
     }
   }*//*
   if(collides(walls, s.airshipLeft)){
     println("Colliding with wall");
     return true;
   }*/
   if(collides(walls.get(0), s.airshipLeft)){
     println("colliding");
     return true;
   }
   
   return false;
 }
 
}