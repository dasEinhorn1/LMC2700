import java.util.Collections;
import java.util.Comparator;
class Slope { 
  LinkedList<Tree> trees;
  LinkedList<BoundingRect> watchCollide;
  Path path;
  
  float startWidth = 5;
  boolean collisionDetected = false;
  
  Slope(int numTrees) {
    trees = new LinkedList<Tree>();
    for (int i = 0; i < numTrees; i++) {
      float x;
      if (i < numTrees / 2) {
        x = random((width - startWidth)/2);
      } else {
        x = random((width + startWidth)/2, width);
      }
      float y = random(getEdgeAt(x), getTreeLineAt(x));
      trees.add(new Tree(x, y));
    }
    Collections.sort(trees, new Comparator<Tree>(){
        @Override
        public int compare(Tree t1, Tree t2) {
          return int(t1.pos.y - t2.pos.y);
        }
    });
    path = new Path();
  }
  
  void draw() {
    fill(255);
    ellipse(width/2, height, width * 1.25, height * 1.5);
    
    if (DEBUG) {
      drawTreeLineBounds();
    }
    path.draw();
    
  }
  
  void drawTrees() {
    for (Tree tree : trees) {
      tree.draw();
    }
  }
  
  void drawTreeLineBounds() {
    fill(255,0,0);
    noStroke();
    for (int x = 0; x < 801; x += 10) {
        float y = getTreeLineAt(x);
        ellipse(x, y, 5, 5);
    }
  }
  
  void update(Sled sled, float angle) {
    path.add(sled.pos.x, sled.pos.y, angle);
    collisionDetected = !onSlope(sled.pos) || checkTreeCollisions(sled);
  }
  
  float getEdgeAt(float x) {
    float b = width * 1.25 - width / 2;
    float a = height * 1.625 - height;
    float h = width/2;
    float k = height;
    float y = -sqrt(abs((1 - pow((x - h)/a, 2)) * pow(b, 2))) + k;
    return y;
  }
  
  float getTreeLineAt(float x) {
    float b = width * 1.25 - width / 2;
    float a = height * 1.4 - height;
    float h = width/2;
    float k = height;
    
    float rtPart = (1 - pow((x - h)/a, 2)) * pow(b, 2);
    float y;
    if (rtPart >= 0) {
      y = -sqrt(rtPart) + k;
    } else {
      y = height;
    }
    return y;
  }
  
  boolean onSlope(PVector pos) {
    return getEdgeAt(pos.x) <= pos.y && pos.y < height;
  }
  
  boolean checkTreeCollisions(Sled s) {
    for (Tree t : trees) {
      BoundingRect tBox = t.getBoundingRect();
      BoundingRect sBox = s.getBoundingRect();
      if (tBox.collidingWith(sBox)) {
        return true;
      }
    }
    return false;
  }
}