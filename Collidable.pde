final int COLLIDABLE_CIRCLE = 0;
final int COLLIDABLE_RECTANGLE = 1;

interface Collidable {

  boolean collidesWith(Collidable c);

  PVector correction(Collidable c);

  float[] getDimensions();

  PVector getLocation();

  int getType();

  void translate(PVector v);

  void rotate(float r); //in radians
}

abstract class CollidableAbstract implements Collidable {
  PVector location;

  CollidableAbstract(PVector location) {
    this.location = location;
  }

  PVector getLocation() {
    return location;
  }
}

class CollidableCircle extends CollidableAbstract {
  float radius;

  CollidableCircle(PVector location, float radius) {
    super(location);
    this.radius = radius;
  }

  boolean collidesWith(Collidable c) {   

    switch(c.getType()) {
    case COLLIDABLE_CIRCLE:
      PVector cLocation = c.getLocation();
      float cRadius = c.getDimensions()[0];
      float distance = location.dist(cLocation);
      float minLocation = radius + cRadius;
      if (distance < minLocation) {
        return true;
      }
      break;
    case COLLIDABLE_RECTANGLE:
      CollidableRectangle r = (CollidableRectangle) c;
      if (collisionCircleRectangle(this, r)) {
        return true;
      }
      break;
    default:
      break;
    }
    return false;
  }

  PVector correction(Collidable c) {

    switch(c.getType()) {
    case COLLIDABLE_CIRCLE:
      CollidableCircle cir = (CollidableCircle) c;
      PVector cirPos = cir.getLocation();
      PVector cirToThis = PVector.sub(cirPos, this.location);
      float dist = this.location.dist(cirPos);
      float[] dims = cir.getDimensions();
      float cirRad = dims[0];
      dist -= cirRad;
      dist -= radius;
      cirToThis.setMag(dist);
      return cirToThis;
    case COLLIDABLE_RECTANGLE:
      CollidableRectangle r = (CollidableRectangle) c;
      break;
    default:
      break;
    }
    return new PVector(0, 0, 0);
  }

  float[] getDimensions() {
    float[] dimensions = {radius};
    return dimensions;
  }


  int getType() {
    return COLLIDABLE_CIRCLE;
  }

  void translate(PVector v) {
    location.add(v);
  }

  void rotate(float r) {
    return;
  }
}

class CollidableRectangle extends CollidableAbstract {
  //Location is one of the vertices
  //Points MUST be in counterclockwise order starting with the location
  PVector v1, v2, v3;

  CollidableRectangle(PVector location, PVector v1, PVector v2, PVector v3) {
    super(location);
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
  }

  boolean collidesWith(Collidable c) {

    switch(c.getType()) {
    case COLLIDABLE_CIRCLE:
      CollidableCircle cir = (CollidableCircle) c;
      if (collisionCircleRectangle(cir, this)) {
        return true;
      }
      break;
    case COLLIDABLE_RECTANGLE:
      CollidableRectangle r = (CollidableRectangle) c;
      break;
    default:
      break;
    }

    return false;
  }

  PVector correction(Collidable c) {
    switch(c.getType()) {
    case COLLIDABLE_CIRCLE:
      CollidableCircle cir = (CollidableCircle) c;
      break;
    case COLLIDABLE_RECTANGLE:
      CollidableRectangle r = (CollidableRectangle) c;
      break;
    default:
      break;
    }
    return new PVector(0, 0, 0);
  }

  float[] getDimensions() {
    float[] dimensions = {location.x, location.y, v1.x, v1.y, v2.x, v2.y, v3.x, v3.y};
    return dimensions;
  }


  int getType() {
    return COLLIDABLE_RECTANGLE;
  }

  void translate(PVector v) {
    location.add(v);
    v1.add(v);
    v2.add(v);
    v3.add(v);
  }

  //Given an angle r to rotate, rotate about center of rectangle
  void rotate(float r) {
    PVector center = calculateCenter(location, v1, v2, v3);
    rotate(r,center);
    return;
  }

  //Given an angle and the axis to rotate around, update collidable
  void rotate(float r, PVector axis) {
    PVector center = axis;
    location.sub(center);
    v1.sub(center);
    v2.sub(center);
    v3.sub(center);

    location.rotate(r);
    v1.rotate(r);
    v2.rotate(r);
    v3.rotate(r);

    location.add(center);
    v1.add(center);
    v2.add(center);
    v3.add(center);

    return;
  }

  PVector getCenter() {
    return calculateCenter(location, v1, v2, v3);
  }
}