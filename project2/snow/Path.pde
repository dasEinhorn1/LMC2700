import java.util.LinkedList;
class Path {
  int maxLength;
  int shapeType;
  LinkedList<PShape> points;
  
  Path() {
    this(RECT, -1);
  }
  
  Path(int shape, int keepNum) {
    points = new LinkedList<PShape>();
    maxLength = keepNum;
    shapeType = shape;
  }
  
  void add(float x, float y, float a) {
    add(createShape(shapeType, x, y, 1 + 5 * sin(a), 1 + 5 * cos(a)));
  }
  
  void add(PShape pathPt) {   
    pathPt.setFill(230);
    if (maxLength > 0 && points.size() >= maxLength) {
      points.add(pathPt);
      points.remove();
    } else {
      points.add(pathPt);
    }
  }
  
  void draw() {
    fill(250);
    for (PShape pt : points) {
      shape(pt);
    }
  }
}