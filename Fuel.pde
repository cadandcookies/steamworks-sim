class Fuel {
  PVector location, velocity, acceleration;
  float radius;
  PShape shape;
  boolean onGround;

  Fuel(PVector location, PVector velocity, float radius) {
    this.location = location;
    this.velocity = velocity;
    this.radius = radius;
    
    shape = createShape(ELLIPSE, location.x, location.y, radius*2, radius*2);
    shape.setFill(fuelColor);
    shape.setStroke(fuelColor);
    
    onGround = true;
  }

  boolean collides(CollidableWall c) {
    float dist = distPointToLine(c.p1, c.p2, location);
    if (dist < radius) {
      return true;
    }
    return false;
  }

  boolean collides(Fuel b) {
    if (location.dist(b.location) < radius + b.radius) {
      return true;
    }
    return false;
  }

  void fixCollision(CollidableWall c) {
    float dist = distPointToLine(c.p1, c.p2, location);
    dist -= radius;
    PVector adjust = PVector.mult(c.normal, -dist);
    move(adjust);
  }

  void fixCollision(Fuel b) {
    PVector normal = PVector.sub(location, b.location);
    float dist = radius + b.radius - b.location.dist(location);
    normal.mult(dist);    
    move(normal);
  }

  void move(PVector p) {
    location.add(p);
    shape.translate(p.x, p.y);
  }

  void bounce(CollidableWall c) {
    velocity = reflect(velocity, c.normal);
    velocity.mult(0.9);
  }

  void bounce(Fuel b) {
    PVector normal = PVector.sub(location, b.location);
    normal.setMag(1);
    velocity = reflect(velocity, normal);
    velocity.mult(0.9);
  }
  
  void updateForces(){
    
  }

  void update() {
    PVector adjust = new PVector(velocity.x, velocity.y);
    velocity.mult(0.999);
    if (velocity.mag() < 0.9) {
      velocity.x = 0;
      velocity.y = 0;
    }
    adjust.mult(DT);
    move(adjust);
  }

  PShape getShape() {
    return shape;
  }
}