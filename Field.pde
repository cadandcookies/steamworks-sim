
class Field {
  PShape shape;
  ArrayList<Collidable> collidableList;

  Field() {
    shape = createShape(GROUP);
    collidableList = new ArrayList<Collidable>();
    makeField();
  }

  ////Field wall locations

  ////Top/Bottom wall points
  //float twY = 50;
  //float twlX = 225;
  //float twrX = 1055;
  //float bwY = 590;
  //float bwlX = 163;
  //float bwrX = 1116;

  ////Side wall points
  //float lwX = 98;
  //float swtY = 119;
  //float swbY = 523;
  //float rwX = 1182;

  void makeField() {

    //Generate walls
    noStroke();
    
    //Top wall
    PVector v1 = new PVector(twlX - 50, twY);
    PVector v2 = new PVector(twrX + 50, twY);
    PVector v3 = new PVector(twrX + 50, twY - 50);
    PVector v4 = new PVector(twlX - 50, twY - 50);
    PShape shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    Collidable c = new CollidableRectangle(v1,v2,v3,v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Bottom wall
    v1 = new PVector(bwrX + 50, bwY);
    v2 = new PVector(bwlX - 50, bwY);
    v3 = new PVector(bwlX - 50, bwY + 50);
    v4 = new PVector(bwrX + 50, bwY + 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1,v2,v3,v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    //Left wall
    v1 = new PVector(lwX, swbY + 50);
    v2 = new PVector(lwX, swtY - 50);
    v3 = new PVector(lwX - 50, swtY - 50);
    v4 = new PVector(lwX - 50, swbY + 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1,v2,v3,v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    //Right wall
    v1 = new PVector(rwX, swtY - 50);
    v2 = new PVector(rwX, swbY + 50);
    v3 = new PVector(rwX + 50, swbY + 50);
    v4 = new PVector(rwX + 50, swtY - 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1,v2,v3,v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    //Top right corner
    
    //Top left corner
    
    //Bottom left corner
    
    //Bottom right corner
    
  }


  PShape getShape() {
    return shape;
  }
}