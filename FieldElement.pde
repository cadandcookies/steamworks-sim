interface FieldElement {
  //Returns shape of field element
  PShape getShape();
  //Returns whether a game object is colliding with the field element
  boolean collidesWith(GameObject g);
  //Returns whether a robot is colliding with the field element
  boolean collidesWith(Robot r);
  //Returns the collision location with game object
  PVector collisionLocation(GameObject g);
  //Returns the collision location with robot
  PVector collisionLocation(Robot r);
  //Corrects position of game object relative to field element and triggers effects
  void correctCollision(GameObject g);
  //Corrects position of robot relative to field element
  void correctCollision(Robot r);
}