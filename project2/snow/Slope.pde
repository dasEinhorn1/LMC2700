class Slope {
  Tree[] trees;
  Path path;
  
  Slope(int numTrees) {
    trees = new Tree[numTrees];
    for (int i = 0; i < numTrees; i++) {
      float x = random(width);
      float y = random(getEdgeAt(x), height);
      trees[i] = new Tree(x, y);
    }
    path = new Path();
  }
  
  void draw() {
    fill(255);
    ellipse(width/2, height, width * 1.25, height * 1.5);
    
    path.draw();
    
    for (int x = 0; x < 801; x += 10) {
      fill(255,0,0);
      float y = getEdgeAt(x);
      ellipse(x, getEdgeAt(x), 5, 5);
      //println(x, y);
    }
  }
  
  void drawTrees() {
    for (int i = 0; i < trees.length; i++) {
      trees[i].draw();
    }
  }
  
  void update(PVector boardPos, float angle) {
    path.add(boardPos.x, boardPos.y, angle);
  }
  
  float getEdgeAt(float x) {
    float b = width * 1.25 - width / 2;
    float a = height * 1.625 - height;
    float h = width/2;
    float k = height;
    float y = -sqrt(abs((1 - pow((x - h)/a, 2)) * pow(b, 2))) + k;
    return y;
  }
  
  boolean onSlope(PVector pos) {
    return getEdgeAt(pos.x) <= pos.y && pos.y < height;
  }
}