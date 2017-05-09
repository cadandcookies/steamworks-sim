class Robot {
  PVector pos;
  PVector dir;
  int wide;
  int high;
  int balls;
  boolean gear;
  
  //Health
  
  Robot(PVector p,PVector d, int w, int h){
    pos = p;
    dir = d;
    wide = w;
    high = h;
    balls = 10;
  }
}