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
    ballsShape = createShape(GROUP);
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
  
  void initializeAirships(){
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
    ballList = new ArrayList<Fuel>();


    for (int i = 0; i < particleCount; i++) {
      addRandomBall();
    }
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
    Fuel b = new Fuel(randomPos.add(center), randomVel, 5);
    ballList.add(b);
    ballsShape.addChild(b.getShape());
  }

  void updateBalls() {

    for (Fuel b : ballList) {
      b.update();
      for (Fuel c : ballList) {
        if (b.collides(c)) {
          if (c.velocity.x != b.velocity.x && c.velocity.y != b.velocity.y) {
            b.fixCollision(c);
            c.bounce(b);
            b.bounce(c);
          }
        }
      }

      fixCollisionsWalls(b, fieldPerimeter);      
      fixCollisionsWalls(b, airshipLeft);      
      fixCollisionsWalls(b, airshipRight);
    }
  }
  
  void dumpHopper(int i){
    
  }
  
  void dumpHopperUL(){
    
  }
  
  void fixCollisionsWalls(Fuel b, ArrayList<CollidableWall> cw){
    for (CollidableWall c : cw) {
        if (b.collides(c)) {
          b.fixCollision(c);
          b.bounce(c);
        }
      }
  }
  
  boolean collides(ArrayList<CollidableWall> p1, ArrayList<CollidableWall> p2){
    for(CollidableWall c : p1){
     for(CollidableWall c2: p2){
      if(c.collides(c2)){
       return true; 
      }
     }
    }
    
    return false;
  }
  
  void drawBalls(){
   shape(ballsShape); 
  }
  
  PShape getBallsShape(){
   return ballsShape; 
  }
  
  void drawNormals(){
   shape(normals); 
  }
  
  PShape getNormals(){
   return normals; 
  }
}