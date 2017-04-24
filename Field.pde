
class Field {
  PShape shape;
  PVector fieldCenter;
  int len;
  int wid;

  Field() {
    fieldCenter = new PVector(width/2, height/2, 0); 
    len = FIELD_LENGTH;
    wid = FIELD_WIDTH;
    shape = createShape(GROUP);
    makeField();
  }
  
  void makeField(){
   makeCarpet();
   makeTape();
   makePerimeter();
  }

  void makeCarpet() {
    rectMode(CENTER);
    
    PShape carpet = createShape(RECT, fieldCenter.x, fieldCenter.y, len + 240, wid + 48);
    carpet.setFill(carpetGreen);
    carpet.setStroke(false);
    shape.addChild(carpet);
    
  }

  void makePerimeter() {
  }

  void makeTape() {
  }
  
  PShape getShape(){
   return shape; 
  }
}