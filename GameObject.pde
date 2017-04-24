interface GameObject {

  //Returns the position of the object
  PVector getPosition();
  //Returns the PShape to display the object
  PShape getShape();
  //Returns the sprite of the object (may not be necessary, Christina please advise
  //PImage getSprite();
  //Returns radius of game object
  float getRadius();
  //Called to update the position of the object
  void update();
}