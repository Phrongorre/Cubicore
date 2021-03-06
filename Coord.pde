/* Coord.pde
 * 
 * Coordinate unit for management of points in "3D" space.
 * 
 * J Karstin Neill 07.30.2019
 */

public class Coord {
  private float mX, mY, mZ;
  
  public Coord() {
    this.setX(0f);
    this.setY(0f);
    this.setZ(0f);
  }
  
  public Coord(float x, float y, float z) {
    this.setX(x);
    this.setY(y);
    this.setZ(z);
  }
  
  public Coord(float f) {
    this.setX(f);
    this.setY(f);
    this.setZ(f);
  }
  
  public Coord(Coord c) {
    this.copy(c);
  }
  
  public float x() {
    return this.mX;
  }
  
  public float y() {
    return this.mY;
  }
  
  public float z() {
    return this.mZ;
  }
  
  public void setX(float x) {
    this.mX = x;
  }
  
  public void setY(float y) {
    this.mY = y;
  }
  
  public void setZ(float z) {
    this.mZ = z;
  }
  
  public Coord makeCopy() {
    Coord c = new Coord(this.x(), this.y(), this.z());
    return c;
  }
  
  public void copy(Coord c) {
    this.setX(c.x());
    this.setY(c.y());
    this.setZ(c.z());
  }
  
  public void constant(float c) {
    this.setX(c);
    this.setY(c);
    this.setZ(c);
  }
  
  public Coord plus(Coord c) {
    return new Coord(this.x()+c.x(), this.y()+c.y(), this.z()+c.z());
  }
  
  public void add(Coord c) {
    this.copy(this.plus(c));
  }
  
  public Coord times(float m) {
    return new Coord(this.x()*m, this.y()*m, this.z()*m);
  }
  
  public void multiplyBy(float m) {
    this.copy(this.times(m));
  }
  
  public Coord negative() {
    return this.times(-1f);
  }
  
  public void negate() {
    this.copy(this.negative());
  }
  
  public Coord minus(Coord c) {
    return this.plus(c.negative());
  }
  
  public void subtract(Coord c) {
    this.copy(this.minus(c));
  }
  
  public Coord dividedBy(float d) {
    if (d < 0f || d > 0f) return this.times(1f/d);
    else print("Cannot divide by zero!");
    return null;
  }
  
  public void divideBy(float d) {
    this.copy(this.dividedBy(d));
  }
  
  public Coord normalized() {
    float size = this.distance();
    if (size > 0f)
      return this.dividedBy(size);
    else return new Coord();
  }
  
  public void normalize() {
    this.copy(this.normalized());
  }
  
  public void clampX(float min, float max) {
    if (this.x() < min) this.setX(min);
    else if (this.x() > max) this.setX(max);
  }
  
  public void clampY(float min, float max) {
    if (this.y() < min) this.setY(min);
    else if (this.y() > max) this.setY(max);
  }
  
  public void clampZ(float min, float max) {
    if (this.z() < min) this.setZ(min);
    else if (this.z() > max) this.setZ(max);
  }

  public Coord rotatedX(float angle) {
    Coord ret = new Coord(this.x(), this.y()*cos(angle)-this.z()*sin(angle), this.y()*sin(angle)+this.z()*cos(angle));
    return ret;
  }

  public Coord rotatedY(float angle) {
    Coord ret = new Coord(this.x()*cos(angle)-this.z()*sin(angle), this.y(), this.x()*sin(angle)+this.z()*cos(angle));
    return ret;
  }

  public Coord rotatedZ(float angle) {
    Coord ret = new Coord(this.x()*cos(angle)-this.y()*sin(angle), this.x()*sin(angle)+this.y()*cos(angle), this.z());
    return ret;
  }
  
  public void rotateX(float angle) {
    this.copy(this.rotatedX(angle));
  }
  
  public void rotateY(float angle) {
    this.copy(this.rotatedY(angle));
  }
  
  public void rotateZ(float angle) {
    this.copy(this.rotatedZ(angle));
  }
  
  public Coord rotatedXAbout(Coord pivot, float angle) {
    return this.minus(pivot).rotatedX(angle).plus(pivot);
  }
  
  public void rotateXAbout(Coord pivot, float angle) {
    this.copy(this.rotatedXAbout(pivot, angle));
  }

  public Coord rotatedYAbout(Coord pivot, float angle) {
    return this.minus(pivot).rotatedY(angle).plus(pivot);
  }
  
  public void rotateYAbout(Coord pivot, float angle) {
    this.copy(this.rotatedYAbout(pivot, angle));
  }
  
  public Coord rotatedZAbout(Coord pivot, float angle) {
    return this.minus(pivot).rotatedZ(angle).plus(pivot);
  }
  
  public void rotateZAbout(Coord pivot, float angle) {
    this.copy(this.rotatedZAbout(pivot, angle));
  }
  
  public float dot(Coord c) {
    return this.x()*c.x()+this.y()*c.y()+this.z()*c.z();
  }
  
  public float distance() {
    return sqrt(this.dot(this));
  }
  
  public float distanceFrom(Coord c) {
    return this.minus(c).distance();
  }
  
  public String toString() {
    String out = "( " + str(this.x()) + ", " + str(this.y()) + ", " + str(this.z()) + ")";
    return out;
  }
}
