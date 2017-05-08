class Graphics{
  PImage fieldBG;
  PImage leftAlliance;
  PImage rightAlliance;
  PImage leftTouchpads;
  PImage rightTouchpads;
  
  Graphics(){
    fieldBG = loadImage("Assets/field-base.png");
    //rightAlliance = loadImage("Assets/right-alliance-low.png");
  }
  void draw(){
    image(fieldBG,76,64);
    //image(rightAlliance,0,0);
  }
  
}