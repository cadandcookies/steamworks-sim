class Gear {
  PShape shape;
  PVector position;
  PVector velocity;
  float radius = GEAR_RADIUS;

  Gear(PVector position, PVector velocity) {
    this.position = position;
    this.velocity = velocity;
    shape = createShape(ELLIPSE, position.x, position.y, GEAR_RADIUS * 2, GEAR_RADIUS * 2);
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
    vel = PVector.mult(velocity, abs(DRAG_FUEL));
    velocity = vel;
    vel = vel.mult(DT);


    position.add(vel);
    shape.translate(vel.x, vel.y, vel.z);
  }
}