class BoundingRect {
  float x1;
  float y1;
  float x2;
  float y2;
  float w;
  float h;
  
  
  BoundingRect(float x, float y, float s) {
    this(x, y, s, s);
  }
  BoundingRect(float x, float y, float w, float h) {
    x1 = x;
    y1 = y;
    x2 = x + w;
    y2 = y + h;
    this.w = w;
    this.h = h;
  }
  
  void draw() {
    noFill();
    strokeWeight(1);
    stroke(0,0,255);
    rect(x1, y1, w, h);
    noStroke();
  }
  
  boolean collidingWith(BoundingRect b) {
    return  x1 < b.x2 && x2 > b.x1 && y1 < b.y2 && y2 > b.y1;
  }
  @Override
  String toString() {
    return "(" + x1 + ", "+ y1 +"), (" + x2 + ", " + y2 + ")";
  }
}