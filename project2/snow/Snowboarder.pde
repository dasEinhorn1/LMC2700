class Snowboarder {
  float DRAG =0.3;
  PVector pos;
  float startH;
  float angle; // where the boarder is headed angle-wise
  PVector velocity;
  PVector force; // force on the border (angle, r)
  float size; 
  
  Snowboarder(float x, float y) {
    pos = new PVector(x, y);
    startH = y;
    velocity = new PVector(0, 0);
    force = new PVector(3 * PI / 2, g);
  }
  
  void draw() {
    
    rect(pos.x - 25, pos.y - 25, 50, 50);
  }
  
  float getDh() {
    return pos.y - startH;
  }
  
  float angle() {
    return PVector.angleBetween(velocity, new PVector(0,1));
  }
  
  PVector getIdealV() {
    float dh = getDh();
    float magnitude = sqrt(2*g*dh);
    if (dh < 0) {
      return null;
    }
    float x = magnitude * sin(angle());
    float y = magnitude * cos(angle());
    PVector vIdeal = new PVector(x, y);
    return vIdeal;
  }
  
  PVector getDragForce() {
    PVector vi = getIdealV();
    if (vi == null) {
      return null;
    }
    println("IDEAL: " + vi);
    vi.x *= 0;
    vi.y *= vi.y;
    PVector dragF = vi.mult(DRAG);
    println("DRAG: " + dragF);
    return dragF;
  }
  
  float getAngleFromMouse(float mX) {
    float xRel = mX - width/2; // mouse relative to the boarder
    println("TURN", xRel);
    int qd = (abs(xRel) == xRel) ? 1 : 0; // 1 if mouse is to the left
    float a = map(xRel, -width/2, width/2, PI *( 0.5f + qd), PI * (1.5 + qd));
    a += PI;
    println(a/PI + "pi");
    return a;
  }
  
  void update(PVector mPos, boolean slowing) {
    // get an angle relative to mouse.x between pi/2 and 3pi/2 
    float angF = getAngleFromMouse(mPos.x);
    
    //force.x = map(mPos.x - pos.x, -width, width, -1, 1);
    //force.y = 1 - map(mPos.y, 0, height, -1.0, 1.0f);
    //if (slowing && force.y > .01) {
    //  force.y = -0.1;
    //} else if (!slowing && force.y < .1) {
    //  force.y = 0.1;
    //}
    force.limit(1);
    PVector fTotal = force.copy(); 
    force.y += g;
    PVector df = getDragForce();
    if (df == null) {
      return;
      //fTotal.sub(df);
    }
    velocity.add(fTotal);

    pos.add(velocity);
    println("V: " + velocity);
  }
}