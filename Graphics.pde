class Graphics {
  PImage fieldBG;
  PImage leftAlliance;
  PImage leftAllianceTape;
  PImage rightAlliance;
  PImage rightAllianceTape;
  PImage leftTouchpads;
  PImage rightTouchpads;
  PImage gearGoals;
  PImage top;
  PImage gui;

  ColorPicker leftCP;
  ColorPicker rightCP;
  color leftColor;
  color rightColor;

  Graphics() {
    fieldBG = loadImage("Assets/field-base2.png");
    rightAlliance = loadImage("Assets/right-alliance.png");
    rightAllianceTape = loadImage("Assets/right-alliance-tape.png");

    leftAlliance = loadImage("Assets/left-alliance.png");
    leftAllianceTape = loadImage("Assets/left-alliance-tape.png");

    top = loadImage("Assets/top-layer.png");
    gui = loadImage("Assets/gui.png");
    gearGoals = loadImage("Assets/gear-goals.png");

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

  void draw1() {
    resetMatrix();
    image(fieldBG, 0, 0);
    image(gui, 0, 0);
    image(gearGoals, 0, 0);
    tint(leftCP.getColorValue());
    image(leftAllianceTape,0,0);
    tint(rightCP.getColorValue());
    image(rightAllianceTape,0,0);
    noTint();
  }

  void draw2() {
    resetMatrix();
    tint(rightCP.getColorValue());
    image(rightAlliance, 0, 0);
    tint(leftCP.getColorValue());
    image(leftAlliance, 0, 0);
    noTint();
    image(top, 0, 0);
    rectMode(CORNER);
  }
  
  void robotDetails(float x, float y, Robot r){
    rectMode(CORNER);
    noStroke();
    fill(255);
    float h = (100 -r.balls)* (157.0/100.0);
    rect(80, 704, 41.844, h);
    
    textSize(18);
    fill(100);
    textAlign(CENTER);
    text(r.balls, 100, 840);
  }
}