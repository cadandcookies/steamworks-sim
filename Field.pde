
class Field {
  PShape shape;
  ArrayList<Collidable> collidableList;

  Field() {
    shape = createShape(GROUP);
    collidableList = new ArrayList<Collidable>();
    makeField();
  }

  void makeField() {

    //Generate walls
    noStroke();

    //Top wall
    PVector v1 = new PVector(twlX - 50, twY);
    PVector v2 = new PVector(twrX + 50, twY);
    PVector v3 = new PVector(twrX + 50, twY - 50);
    PVector v4 = new PVector(twlX - 50, twY - 50);
    PShape shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    Collidable c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Bottom wall
    v1 = new PVector(bwrX + 50, bwY);
    v2 = new PVector(bwlX - 50, bwY);
    v3 = new PVector(bwlX - 50, bwY + 50);
    v4 = new PVector(bwrX + 50, bwY + 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Left wall
    v1 = new PVector(lwX, swbY + 50);
    v2 = new PVector(lwX, swtY - 50);
    v3 = new PVector(lwX - 50, swtY - 50);
    v4 = new PVector(lwX - 50, swbY + 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Right wall
    v1 = new PVector(rwX, swtY - 50);
    v2 = new PVector(rwX, swbY + 50);
    v3 = new PVector(rwX + 50, swbY + 50);
    v4 = new PVector(rwX + 50, swtY - 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Top right corner
    v1 = new PVector(rwX, swtY);
    v2 = new PVector(rwX + 50, swtY - 50);
    v3 = new PVector(twrX + 50, twY - 50);
    v4 = new PVector(twrX, twY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Top left corner
    v1 = new PVector(lwX, swtY);
    v2 = new PVector(twlX, twY);
    v3 = new PVector(twlX - 50, twY - 50);
    v4 = new PVector(lwX - 50, swtY - 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Bottom left corner
    v2 = new PVector(lwX, swbY);
    v1 = new PVector(bwlX, bwY);
    v3 = new PVector(lwX - 50, swbY + 50);
    v4 = new PVector(bwlX - 50, bwY + 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Bottom right corner
    v1 = new PVector(rwX, swbY);
    v2 = new PVector(bwrX, bwY);
    v3 = new PVector(bwrX + 50, bwY + 50);
    v4 = new PVector(rwX + 50, swbY + 50);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);

    //Left airship boxes
    v1 = new PVector(hexLL, hexTopMidY);
    v2 = new PVector(hexLL, hexBotMidY);
    v3 = new PVector(hexLR, hexBotMidY);
    v4 = new PVector(hexLR, hexTopMidY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    v1 = new PVector(hexLM, hexTopY);
    v2 = new PVector(hexLL, hexTopMidY);
    v3 = new PVector(hexLM, hexBotY);
    v4 = new PVector(hexLR, hexBotMidY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    v1 = new PVector(hexLM, hexTopY);
    v2 = new PVector(hexLL, hexBotMidY);
    v3 = new PVector(hexLM, hexBotY);
    v4 = new PVector(hexLR, hexTopMidY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);


    //Right airship boxes
    v1 = new PVector(hexRL, hexTopMidY);
    v2 = new PVector(hexRL, hexBotMidY);
    v3 = new PVector(hexRR, hexBotMidY);
    v4 = new PVector(hexRR, hexTopMidY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    v1 = new PVector(hexRM, hexTopY);
    v2 = new PVector(hexRL, hexTopMidY);
    v3 = new PVector(hexRM, hexBotY);
    v4 = new PVector(hexRR, hexBotMidY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);
    
    v1 = new PVector(hexRM, hexTopY);
    v2 = new PVector(hexRL, hexBotMidY);
    v3 = new PVector(hexRM, hexBotY);
    v4 = new PVector(hexRR, hexTopMidY);
    shape = createShape(QUAD, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y, v4.x, v4.y);
    c = new CollidableRectangle(v1, v2, v3, v4);
    collidableList.add(c);
    this.shape.addChild(shape);
  }

  ////Airship locations
  //float hexTopY = 255;
  //float hexTopMidY = 290;
  //float hexBotMidY = 357;
  //float hexBotY = 395;

  //float hexLL = 287;
  //float hexLM = 345;
  //float hexLR = 404;

  //float hexRL = 877;
  //float hexRM = 935;
  //float hexRR = 994;


  PShape getShape() {
    return shape;
  }
}