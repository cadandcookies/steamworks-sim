

//-----------------------------------------------------------------------------------------------------
//
// COLLISION EQUATIONS
//
//-----------------------------------------------------------------------------------------------------



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

PVector calculateCenter(PVector location, PVector  v1, PVector  v2, PVector  v3) {
  PVector p = new PVector(0, 0);

  float l1 = determinant(location.x, location.y, v2.x, v2.y);
  float l1x1 = determinant(location.x, 1, v2.x, 1);
  float l2 = determinant(v1.x, v1.y, v3.x, v3.y);
  float l2x1 = determinant(v1.x, 1, v3.x, 1);
  float l1y1 = determinant(location.y, 1, v2.y, 1);
  float l2y1 = determinant(v1.y, 1, v3.y, 1);

  float den = determinant(l1x1, l1y1, l2x1, l2y1);

  float xnum = determinant(l1, l1x1, l2, l2x1);
  float ynum = determinant(l1, l1y1, l2, l2y1);

  p.x = xnum / den;
  p.y = ynum / den;

  return p;
}

float determinant(float ul, float ur, float bl, float br) {
  return ul*br - ur*bl;
}

PVector calcNormal(PVector p1, PVector p2) {
  float dx = p2.x - p1.x;
  float dy = p2.y - p1.y;
  return new PVector(-dy, dx);
}
PVector calcNegNormal(PVector p1, PVector p2) {
  float dx = p2.x - p1.x;
  float dy = p2.y - p1.y;
  return new PVector(dy, -dx);
}

PVector midPoint(PVector p1, PVector p2) {
  float m1 = (p1.x + p2.x)/2;
  float m2 = (p1.y + p2.y)/2;
  return new PVector(m1, m2);
}

//Assumes normal is a unit normal
PVector reflect(PVector p1, PVector normal) {
  PVector d2 = PVector.mult(p1, 2);
  float mul = d2.dot(normal);
  return PVector.sub(p1, PVector.mult(normal, mul));
}

//location to v2
//v1 to v3
PVector intersection(PVector location, PVector  v1, PVector  v2, PVector  v3) {
  PVector p = new PVector(0, 0);

  float l1 = determinant(location.x, location.y, v2.x, v2.y);
  float l1x1 = determinant(location.x, 1, v2.x, 1);
  float l2 = determinant(v1.x, v1.y, v3.x, v3.y);
  float l2x1 = determinant(v1.x, 1, v3.x, 1);
  float l1y1 = determinant(location.y, 1, v2.y, 1);
  float l2y1 = determinant(v1.y, 1, v3.y, 1);

  float den = determinant(l1x1, l1y1, l2x1, l2y1);

  float xnum = determinant(l1, l1x1, l2, l2x1);
  float ynum = determinant(l1, l1y1, l2, l2y1);

  p.x = xnum / den;
  p.y = ynum / den;

  return p;
}

boolean lineSegmentCollision(PVector l11, PVector l12, PVector l21, PVector l22) {
  PVector intersect = intersection(l11, l21, l12, l22);
  float dist = distPointToLine(intersect, l11, l12);
  if (dist <= 0.5) {
    return true;
  } 
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

PVector rotateAboutPoint(PVector v, PVector axis, float r) {
  PVector ret = new PVector(v.x, v.y);
  ret.sub(axis);
  ret.rotate(r);
  ret.add(axis);
  return ret;
}

boolean collides(ArrayList<CollidableWall> p1, ArrayList<CollidableWall> p2) {
  for (CollidableWall c : p1) {
    for (CollidableWall c2 : p2) {
      if (c.collides(c2)) {
        return true;
      }
    }
  }

  return false;
}

boolean collides(CollidableWall c, ArrayList<CollidableWall> body) {
  for (CollidableWall cw : body) {
    if (c.collides(cw)) {
      return true;
    }
  }

  return false;
}