class Slope { 
  LinkedList<Tree> trees;
  LinkedList<BoundingRect> watchCollide;
  Path path;
  LinkedList<Path> oldPaths;
  float startWidth = 30;
  boolean collisionDetected = false;
  
  Slope() {
    trees = new LinkedList<Tree>();
    for (int i = 0; i < NUM_TREES; i++) {
      float x;
      if (i < NUM_TREES / 2) {
        x = random((width - startWidth)/2);
      } else {
        x = random((width + startWidth)/2, width);
      }
      float yLim = (GET_MOM_MODE) ? height : getTreeLineAt(x);
      float y = random(getEdgeAt(x), yLim);
      trees.add(new Tree(x, y));
    }
    Collections.sort(trees, new Comparator<Tree>(){
        @Override
        public int compare(Tree t1, Tree t2) {
          return int(t1.pos.y - t2.pos.y);
        }
    });
    path = new Path();
    oldPaths = new LinkedList<Path>();
  }
  
  void draw() {
    fill(255);
    ellipse(width/2, height, width * 1.25, height * 1.5);
    
    if (DEBUG) {
      drawTreeLineBounds();
    }
    for (Path p : oldPaths) {
        p.draw();
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
    path.add(sled.pos.x, sled.pos.y, angle, sled.rSize());
    collisionDetected = !onSlope(sled.pos) || checkTreeCollisions(sled);
    if (collisionDetected) {
      oldPaths.add(path);
      path = new Path();
    }
  }
  
  void updatePaths() {
    LinkedList<Path> killList = new LinkedList<Path>();
    for (Path p : oldPaths) {
      boolean dead = p.fade();
      if (dead) {
        killList.add(p);
      }
    }
    while (!killList.isEmpty()) {
      oldPaths.remove(killList.remove());
    }
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