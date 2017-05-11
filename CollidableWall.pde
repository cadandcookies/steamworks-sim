class CollidableWall {
  PVector p1, p2, normal;
  PShape shape;

  CollidableWall(PVector p1, PVector p2, boolean negNormal) {
    PVector normal;
    if (negNormal) {
      normal = calcNegNormal(p1, p2);
    } else {
      normal = calcNormal(p1, p2);
    }

    normal.setMag(1);

    this.p1 = p1;
    this.p2 = p2;
    this.normal = normal;

    PVector triPoint = midPoint(p1, p2).add(PVector.mult(normal, 20));

    shape = createShape(TRIANGLE, p1.x, p1.y, p2.x, p2.y, triPoint.x, triPoint.y);
    shape.setStroke(color(140, 140, 140));
    shape.setFill(color(140, 140, 140));
  }
  
  boolean collides(CollidableWall c){
    return lineSegmentCollision(this.p1, this.p2, c.p1, c.p2);
  }

  PShape getShape() {
    return shape;
  }
}