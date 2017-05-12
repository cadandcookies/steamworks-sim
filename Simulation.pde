class Simulation {
  ArrayList<CollidableWall> fieldPerimeter;
  ArrayList<CollidableWall> boilerLeft;
  ArrayList<CollidableWall> boilerRight;
  ArrayList<CollidableWall> airshipLeft;
  ArrayList<CollidableWall> airshipRight;
  ArrayList<Fuel> ballList;
  PShape normals;
  PShape ballsShape;

  int particleCount = 50;

  Simulation() {
    normals = createShape(GROUP);

    initializeField();
    initializeAirships();
    initializeBalls();
  }


  void initializeField() {
    fieldPerimeter = new ArrayList<CollidableWall>();
    PVector twL = new PVector(twlX, twY);
    PVector twR = new PVector(twrX, twY);
    PVector lwT = new PVector(lwX, swtY);
    PVector lwB = new PVector(lwX, swbY);
    PVector rwT = new PVector(rwX, swtY);
    PVector rwB = new PVector(rwX, swbY);
    PVector bwL = new PVector(bwlX, bwY);
    PVector bwR = new PVector(bwrX, bwY);

    addCollidable(twR, twL, true, fieldPerimeter);
    addCollidable(twL, lwT, true, fieldPerimeter);
    addCollidable(lwT, lwB, true, fieldPerimeter);
    addCollidable(lwB, bwL, true, fieldPerimeter);
    addCollidable(bwL, bwR, true, fieldPerimeter);
    addCollidable(bwR, rwB, true, fieldPerimeter);
    addCollidable(rwB, rwT, true, fieldPerimeter);
    addCollidable(rwT, twR, true, fieldPerimeter);


    for (CollidableWall c : fieldPerimeter) {
      normals.addChild(c.getShape());
    }
  }

  void initializeAirships() {
    airshipLeft = new ArrayList<CollidableWall>();
    airshipRight = new ArrayList<CollidableWall>();
    PVector lT = new PVector(hexLM, hexTopY);
    PVector llmT = new PVector(hexLL, hexTopMidY);
    PVector llmB = new PVector(hexLL, hexBotMidY);
    PVector lB = new PVector(hexLM, hexBotY);
    PVector lrmB = new PVector(hexLR, hexBotMidY);
    PVector lrmT = new PVector(hexLR, hexTopMidY);

    addCollidable(lT, llmT, false, airshipLeft);
    addCollidable(llmT, llmB, false, airshipLeft);
    addCollidable(llmB, lB, false, airshipLeft);
    addCollidable(lB, lrmB, false, airshipLeft);
    addCollidable(lrmB, lrmT, false, airshipLeft);
    addCollidable(lrmT, lT, false, airshipLeft);

    for (CollidableWall c : airshipLeft) {
      normals.addChild(c.getShape());
    }

    PVector rT = new PVector(hexRM, hexTopY);
    PVector rlmT = new PVector(hexRL, hexTopMidY);
    PVector rlmB = new PVector(hexRL, hexBotMidY);
    PVector rB = new PVector(hexRM, hexBotY);
    PVector rrmB = new PVector(hexRR, hexBotMidY);
    PVector rrmT = new PVector(hexRR, hexTopMidY);

    addCollidable(rT, rlmT, false, airshipRight);
    addCollidable(rlmT, rlmB, false, airshipRight);
    addCollidable(rlmB, rB, false, airshipRight);
    addCollidable(rB, rrmB, false, airshipRight);
    addCollidable(rrmB, rrmT, false, airshipRight);
    addCollidable(rrmT, rT, false, airshipRight);

    for (CollidableWall c : airshipRight) {
      normals.addChild(c.getShape());
    }
  }

  void initializeBalls() {
    ballsShape = createShape(GROUP);
    ballList = new ArrayList<Fuel>();


    //for (int i = 0; i < particleCount; i++) {
    //  addRandomBall();
    //}
  }

  void resetFuel() {
    ballList = new ArrayList<Fuel>();
    ballsShape = createShape(GROUP);
    hopperUL = false;
    hopperUR = false;
    hopperLL = false;
    hopperLM = false;
    hopperLR = false;
  }


  void addCollidable(PVector p1, PVector p2, boolean negNormal, ArrayList<CollidableWall> coll) {
    CollidableWall c = new CollidableWall(p1, p2, negNormal);
    coll.add(c);
  }

  float spread = 100;
  float entropy = 200;
  void addRandomBall() {
    PVector randomPos = PVector.random2D().mult(spread);
    PVector randomVel = PVector.random2D().mult(entropy);
    //println("Velocity: " + randomVel.x + "," + randomVel.y);
    Fuel b = new Fuel(randomPos.add(center), randomVel, 3);
    ballList.add(b);
    ballsShape.addChild(b.getShape());
  }

  void updateBalls() {
    for (Fuel b : ballList) {
      b.update();
      for (Fuel c : ballList) {
        if (b.onGround && c.onGround) {
          if (b.collides(c)) {
            if (c.velocity.x != b.velocity.x && c.velocity.y != b.velocity.y) {
              b.fixCollision(c);
              c.bounce(b);
              b.bounce(c);
            }
          }
        }
      }


      fixCollisionsWalls(b, fieldPerimeter);
      if (b.onGround) {
        fixCollisionsWalls(b, airshipLeft);      
        fixCollisionsWalls(b, airshipRight);
        fixCollisionsWalls(b, r.walls);
      }
      if (b.location.y < 52) {
        float dist = 52 - b.location.y;
        b.move(new PVector(0, dist + 3));
      }

      if (b.location.y > 589) {
        float dist = 589 - b.location.y;
        b.move(new PVector(0, dist - 3));
      }
    }
  }

  void addBall(PVector location, PVector velocity) {
    Fuel b = new Fuel(location, velocity, 3);
    ballList.add(b);
    ballsShape.addChild(b.getShape());
  }

  void addFlyingBall(PVector location, PVector velocity) {
    Fuel b = new Fuel(location, velocity, 3);
    b.makeFlying();
    ballList.add(b);
    ballsShape.addChild(b.getShape());
  }

  float hopperIntensity = 100;
  float hopperSpread = 20;

  boolean hopperUL = false;
  boolean hopperUR = false;
  boolean hopperLL = false;
  boolean hopperLM = false;
  boolean hopperLR = false;
  void dumpHopper(int i) {
    PVector leftCenter = new PVector(0, 0);
    PVector rightCenter = new PVector(0, 0);
    boolean top = true;
    boolean dump = false;

    switch(i) {
    case 0:
      leftCenter = new PVector(392, 60);
      rightCenter = new PVector(486, 60);
      top = true;
      if (!hopperUL) {
        dump = true;
      }
      hopperUL = true;
      break;
    case 1:
      leftCenter = new PVector(790, 60);
      rightCenter = new PVector(885, 60);
      top = true;
      if (!hopperUR) {
        dump = true;
      }
      hopperUR = true;
      break;
    case 2:
      leftCenter = new PVector(247, 584);
      rightCenter = new PVector(341, 584);
      top = false;
      if (!hopperLL) {
        dump = true;
      }
      hopperLL = true;
      break;
    case 3:
      leftCenter = new PVector(591, 584);
      rightCenter = new PVector(686, 584);
      top = false;
      if (!hopperLM) {
        dump = true;
      }
      hopperLM = true;
      break;
    case 4:
      leftCenter = new PVector(934, 584);
      rightCenter = new PVector(1028, 584);
      top = false;
      if (!hopperLR) {
        dump = true;
      }
      hopperLR = true;
      break;
    default:
    }

    if (dump) {
      for (int j = 0; j < 50; j++) {
        float angle = random(10*PI/32, 20*PI/32);
        if (!top) {
          angle -= PI;
        }
        PVector randAngle = PVector.fromAngle(angle);
        addBall(PVector.add(leftCenter, PVector.mult(randAngle, hopperSpread)), PVector.mult(randAngle, hopperIntensity));

        angle = random(10*PI/32, 20*PI/32);
        if (!top) {
          angle -= PI;
        }
        randAngle = PVector.fromAngle(angle);
        addBall(PVector.add(rightCenter, PVector.mult(randAngle, hopperSpread)), PVector.mult(randAngle, hopperIntensity));
      }
    }
  }

  void dumpHopperUL() {
    dumpHopper(0);
  }

  void dumpHopperUR() {
    dumpHopper(1);
  }

  void dumpHopperLL() {
    dumpHopper(2);
  }

  void dumpHopperLM() {
    dumpHopper(3);
  }

  void dumpHopperLR() {
    dumpHopper(4);
  }

  void fixCollisionsWalls(Fuel b, ArrayList<CollidableWall> cw) {
    for (CollidableWall c : cw) {
      if (b.collides(c)) {
        b.fixCollision(c);
        b.bounce(c);
      }
    }
  }

  void drawNormals2() {
    for (CollidableWall w : fieldPerimeter) {
      shape(w.getShape());
    }

    for (CollidableWall w : airshipLeft) {
      shape(w.getShape());
    }

    for (CollidableWall w : airshipRight) {
      shape(w.getShape());
    }
  }


  void drawBalls() {
    shape(ballsShape);
  }

  PShape getBallsShape() {
    return ballsShape;
  }

  void drawNormals() {
    shape(normals);
  }

  PShape getNormals() {
    return normals;
  }

  ArrayList<ArrayList<CollidableWall>> getFieldCollides() {
    ArrayList<ArrayList<CollidableWall>> l = new ArrayList<ArrayList<CollidableWall>>();
    l.add(fieldPerimeter);
    //l.add(boilerLeft);
    //l.add(boilerRight);
    l.add(airshipLeft);
    l.add(airshipRight);
    return l;
  }
}