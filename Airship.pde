
class Airship implements FieldElement {
  PShape shape;
  PVector position;

  Airship(PVector position, int col) {
    this.position = position;
    shape = createShape(GROUP);
  }

  //Returns shape of field element
  PShape getShape() {
    return shape;
  }
  //Returns whether a game object is colliding with the field element
  boolean collidesWith(GameObject g) {
    return false;
  }
  //Returns whether a robot is colliding with the field element
  boolean collidesWith(Robot r) {
    return false;
  }
  //Returns the collision location with game object
  PVector collisionLocation(GameObject g) {
    PVector collisionLocation = new PVector(0, 0, 0);
    return collisionLocation;
  }
  //Returns the collision location with robot
  PVector collisionLocation(Robot r) {
    PVector collisionLocation = new PVector(0, 0, 0);
    return collisionLocation;
  }
  //Corrects position of game object relative to field element and triggers effects
  void correctCollision(GameObject g) {
  }
  //Corrects position of robot relative to field element
  void correctCollision(Robot r) {
  }
}