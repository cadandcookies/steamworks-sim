
class Field {
  PShape shape;
  PVector fieldCenter;
  int len;
  int wid;
  ArrayList<FieldElement> fieldElements;

  Field() {
    fieldCenter = new PVector(width/2, height/2, 0); 
    len = FIELD_LENGTH;
    wid = FIELD_WIDTH;
    shape = createShape(GROUP);
    fieldElements = new ArrayList<FieldElement>();
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
    PShape perimeter = createShape(GROUP);
    rectMode(CENTER);
    PShape topWall = createShape(RECT, fieldCenter.x, fieldCenter.y - wid/2 - PERIMETER_WIDTH/2, len, PERIMETER_WIDTH);
    perimeter.addChild(topWall);
    PShape bottomWall = createShape(RECT, fieldCenter.x, fieldCenter.y + wid/2 + PERIMETER_WIDTH/2, len, PERIMETER_WIDTH);
    perimeter.addChild(bottomWall);
    PShape leftWall = createShape(RECT, fieldCenter.x - len/2 - PERIMETER_WIDTH/2, fieldCenter.y, PERIMETER_WIDTH, wid);
    perimeter.addChild(leftWall);
    PShape rightWall = createShape(RECT, fieldCenter.x + len/2 + PERIMETER_WIDTH/2, fieldCenter.y, PERIMETER_WIDTH, wid);
    perimeter.addChild(rightWall);
    
    
    shape.addChild(perimeter);
  }

  void makeTape() {
    
  }
  
  PShape getShape(){
   return shape; 
  }
}