class Graphics{
  PImage fieldBG;
  PImage leftAlliance;
  PImage rightAlliance;
  PImage leftTouchpads;
  PImage rightTouchpads;
  PImage top;
  
  Graphics(){
    fieldBG = loadImage("Assets/field-base2.png");
    rightAlliance = loadImage("Assets/right-alliance.png");
    leftAlliance = loadImage("Assets/left-alliance.png");
    top = loadImage("Assets/top-layer.png");

  }
  void draw(){
    image(fieldBG,0,0);
    image(rightAlliance,0,0);
    image(leftAlliance,0,0);
    image(top,0,0);
  }
  
}