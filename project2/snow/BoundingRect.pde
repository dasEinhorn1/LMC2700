class BoundingRect {
  float x1;
  float y1;
  float x2;
  float y2;
  
  BoundingRect(float x, float y, float w, float h) {
    x1 = x;
    y1 = y;
    x2 = x + w;
    y2 = y + h;
  }
  
  boolean collidingWith(BoundingRect b) {
    return x1 < b.x2 && x2 > b.x1 && y1 < b.y2 && y2 > b.y1;
  }
}