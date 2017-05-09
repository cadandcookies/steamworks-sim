

//-----------------------------------------------------------------------------------------------------
//
// COLLISION EQUATIONS
//
//-----------------------------------------------------------------------------------------------------

//This StackOverflow post was invaluable towards finding the right equations for collision functions:
//http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection

//Checks if a point is in a rectangle
boolean pointInRectangle(PVector p, CollidableRectangle r) {
  float[] dims = r.getDimensions();
  PVector v1 = new PVector(dims[0], dims[1]);
  PVector v2 = new PVector(dims[2], dims[3]);
  PVector v3 = new PVector(dims[4], dims[5]);
  PVector v4 = new PVector(dims[6], dims[7]);

  if (!isToLeft(p, v1, v2)) {
    return true;
  }

  if (!isToLeft(p, v2, v3)) {
    return true;
  }
  
  if (!isToLeft(p, v3, v4)) {
    return true;
  }
  
  if (!isToLeft(p, v4, v1)) {
    return true;
  }

  return false;
}

////Checks if a point is in a rectangle
//boolean pointInTriangle(PVector p, CollidableTriangle t) {
//  float[] dims = t.getDimensions();
//  PVector v1 = new PVector(dims[0], dims[1]);
//  PVector v2 = new PVector(dims[2], dims[3]);
//  PVector v3 = new PVector(dims[4], dims[5]);

//  if (!isToLeft(p, v1, v2)) {
//    return true;
//  }

//  if (!isToLeft(p, v2, v3)) {
//    return true;
//  }

//  if (!isToLeft(p, v3, v1)) {
//    return true;
//  }

//  return false;
//}

//Checks if a point is to the left of a line segment
//(Useful for checking collisions with convex polygons)
boolean isToLeft(PVector point, PVector p1, PVector p2) {
  float a = -(p2.y - p1.y);
  float b = p2.x - p1.x;
  float c = -(a*p1.x + b*p1.y);
  float d = a*point.x + b*point.y + c;
  if (d > 0) {
    return true;
  }
  return false;
}

//Checks if a circle intersects with a line segment
boolean intersectCircle(CollidableCircle c, PVector v1, PVector v2) {
  PVector p = c.getLocation();
  float dist = distPointToLine(v1, v2, p);
  if (dist <= c.radius) {
    return true;
  }
  return false;
}


// Checks if a circle collides with a rectangle
boolean collisionCircleRectangle(CollidableCircle c, CollidableRectangle r) {  

  if (pointInRectangle(c.getLocation(), r)) {
    return true;
  }

  float[] dims = r.getDimensions();
  PVector v1 = new PVector(dims[0], dims[1]);
  PVector v2 = new PVector(dims[2], dims[3]);
  PVector v3 = new PVector(dims[4], dims[5]);
  PVector v4 = new PVector(dims[6], dims[7]);

  if (intersectCircle(c, v1, v2)) {
    return true;
  }

  if (intersectCircle(c, v2, v3)) {
    return true;
  }

  if (intersectCircle(c, v3, v4)) {
    return true;
  }

  if (intersectCircle(c, v4, v1)) {
    return true;
  }

  return false;
}

////Checks if a circle collides with a triangle
//boolean collisionCircleTriangle(CollidableCircle c, CollidableTriangle t) {
//  if (pointInTriangle(c.getLocation(), t)) {
//    return true;
//  }

//  float[] dims = t.getDimensions();
//  PVector v1 = new PVector(dims[0], dims[1]);
//  PVector v2 = new PVector(dims[2], dims[3]);
//  PVector v3 = new PVector(dims[4], dims[5]);

//  if (intersectCircle(c, v1, v2)) {
//    return true;
//  }

//  if (intersectCircle(c, v2, v3)) {
//    return true;
//  }

//  if (intersectCircle(c, v3, v1)) {
//    return true;
//  }
//  return false;
//}

//Checks if a rectangle collides with a rectangle
boolean collisionRectangleRectangle(CollidableRectangle r1, CollidableRectangle r2) {
  return false;
}

// Checks distance betweein a point and a line segmenr
float distPointToLine(PVector start, PVector end, PVector point) {
  PVector n = PVector.sub(end, start);
  PVector pa = PVector.sub(start, point);

  float c = PVector.dot(n, pa);

  if (c > 0.0) {
    return  sqrt(PVector.dot(pa, pa));
  }

  PVector bp = PVector.sub(point, end);

  if (PVector.dot(n, bp) > 0) {
    return sqrt(PVector.dot(bp, bp));
  }

  PVector e = PVector.sub(pa, PVector.mult(n, c / PVector.dot(n, n)));

  return sqrt(PVector.dot(e, e));
}