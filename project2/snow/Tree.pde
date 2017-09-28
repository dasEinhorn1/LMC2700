color closeTreeColor = color(0, 77, 0);
color farTreeColor = color(32, 96, 64);

class Tree implements Comparable {
  PVector pos;
  PVector dim;
  float scale;

  Tree(float x, float y) {
    this(x, y, map(y, 0, height, .5, 6));
  }

  Tree(float x, float y, float scl) {
    dim = new PVector(10, 20);
    dim.mult(scl);
    pos = new PVector(x,y); 
    this.scale = scl;
  }
  
  void draw() {
    stroke(153, 77, 0);
    strokeWeight(dim.x / 4);
    strokeCap(0);
    line(pos.x, pos.y, pos.x, pos.y - dim.y / 2);
    noStroke();
    color treeColor = lerpColor(farTreeColor, closeTreeColor, pos.y / (height * 1.5));
    fill(treeColor);
    strokeWeight(dim.x / 4);
    triangle(pos.x, pos.y - dim.y, pos.x - dim.x / 2.5, pos.y - dim.y / 2, pos.x + dim.x / 2.5, pos.y - dim.y / 2);
    triangle(pos.x, pos.y - 3 * dim.y / 4, pos.x - dim.x / 2, pos.y - dim.y / 4, pos.x + dim.x / 2, pos.y - dim.y / 4);
    if (DEBUG) {
      getBoundingRect().draw();
    }
  }
  
  BoundingRect getBoundingRect() {
    return new BoundingRect(pos.x - dim.x/ 8, pos.y - dim.x / 4, dim.x/4, dim.x/4);
  }
  
  int compareTo(Object t) {
    if (!(t instanceof Tree)) {
      throw new IllegalArgumentException("Not a tree.");
    }
    return int(pos.y - ((Tree)t).pos.y);
  }
}