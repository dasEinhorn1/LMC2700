class Path {
  int maxLength;
  int shapeType;
  boolean dead;
  float fadeCount;
  LinkedList<PShape> points;
  
  Path() {
    this(RECT, -1);
  }
  
  Path(int shape, int keepNum) {
    fadeCount = 200;
    points = new LinkedList<PShape>();
    maxLength = keepNum;
    shapeType = shape;
    dead = false;
  }
  
  void add(float x, float y, float a, float size) {
    float sX = size/2 * cos(a);
    float sY = size/2 * cos(a);
    add(createShape(shapeType, x - sX/2, y, 1 + sX, 1 + sY));
  }
  
  void add(PShape pathPt) { 
    if (maxLength > 0 && points.size() >= maxLength) {
      points.add(pathPt);
      points.remove();
    } else {
      points.add(pathPt);
    }
  }
  
  void draw() {
    color clr = color(fadeCount);
    for (PShape pt : points) {
      fill(clr);
      pt.setFill(clr);
      pt.setStroke(clr);
      shape(pt);
    }
  }
  
  boolean fade() {
    println(FADE_RATE);
    fadeCount += FADE_RATE;
    if (fadeCount >= 255) {
      dead = true;
    }
    return dead;
  }
  
}