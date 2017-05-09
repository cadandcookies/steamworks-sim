class Graphics{
  PImage fieldBG;
  PImage leftAlliance;
  PImage rightAlliance;
  PImage leftTouchpads;
  PImage rightTouchpads;
  PImage top;
  PImage gui;
  
  ColorPicker leftCP;
  ColorPicker rightCP;
  color leftColor;
  color rightColor;
  
  Graphics(){
    fieldBG = loadImage("Assets/field-base2.png");
    rightAlliance = loadImage("Assets/right-alliance.png");
    leftAlliance = loadImage("Assets/left-alliance.png");
    top = loadImage("Assets/top-layer.png");
    gui = loadImage("Assets/gui.png");
    
    leftCP = cp5.addColorPicker("left alliance picker")
          .setPosition(72, 930)
          .setColorValue(color(232, 83, 94, 255))
          ;
    rightCP = cp5.addColorPicker("right alliance picker")
          .setPosition(952, 930)
          .setColorValue(color(51, 89, 226, 255))
          ;
          
    leftColor = #E9535E;
    rightColor = #3359e2;
  }
  
  void draw(){
    image(fieldBG,0,0);
    image(gui,0,0);
    tint(rightCP.getColorValue());
    image(rightAlliance,0,0);
    tint(leftCP.getColorValue());
    image(leftAlliance,0,0);
    noTint();
    image(top,0,0);
  }
  
}