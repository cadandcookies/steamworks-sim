class Fuel implements GameObject {
  PShape shape;
  PVector position;
  PVector velocity;
  float radius = FUEL_RADIUS;

  Fuel(PVector position, PVector velocity) {
    this.position = position;
    this.velocity = velocity;
    shape = createShape(ELLIPSE, position.x, position.y, FUEL_RADIUS * 2, FUEL_RADIUS * 2);
  }

  //Returns the position of the object
  PVector getPosition() {
    return position;
  }
  //Returns the PShape to display the object
  PShape getShape() {
    return shape;
  }
  //Returns the sprite of the object (may not be necessary, Christina please advise
  //PImage getSprite(){}

  float getRadius() {
    return radius;
  }
  //Called to update the position of the object
  void update() {
    PVector vel; 
    if (velocity.z == 0) {
      vel = PVector.mult(velocity, abs(DRAG_FUEL));
      velocity = vel;
      vel = vel.mult(DT);
    } else {
      vel = new PVector(velocity.x, velocity.y, velocity.z);
      vel.sub(new PVector(0, 0, GRAVITY * DT));
      velocity = vel;
      vel = vel.mult(DT);
    }

    position.add(vel);
    shape.translate(vel.x, vel.y, vel.z);
  }
}