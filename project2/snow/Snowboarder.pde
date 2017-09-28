class Snowboarder {
  PVector pos;
  float startH;
  PVector velocity;
  PVector force; // force on the border (angle, r)
  float size; 
  
  Snowboarder(float x, float y) {
    this(x, y, 10);
  }
  
  Snowboarder(float x, float y, float sz) {
    pos = new PVector(x, y);
    startH = y;
    velocity = new PVector(0, 0.00001);
    force = new PVector(3 * PI / 2, g);
    size = sz;
  }
  
  void draw() {
    noStroke();
    fill(200);
    
    rect(pos.x - size / 2, pos.y - size / 2, size, size);
  }
  
  float getDh() {
    return pos.y - startH;
  }
  
  float angle() {
    return PVector.angleBetween(velocity, new PVector(0,1));
  }
  
  PVector forceDrag() {
    float aVel = velocity.heading();
    float magV = velocity.mag();
    float newMag = pow(magV, 2) * DRAG;
    PVector dragF = PVector.fromAngle(aVel + PI); // need to add more in the y direction than the x
    dragF.mult(newMag);
    return dragF;
  }
  
  PVector forceMouse(float mX) {
    float xRel = mX - width/2; // relative to center
    float xReduced = map(xRel, -width/2, width/2, M_FORCE, -M_FORCE);
    println(xReduced);
    // int dir = (abs(xRel) == xRel) ? 1 : -1; // 1 if mouse is to the left
    float aVel = velocity.heading();
    println("VEL ANGLE: " + aVel);
    PVector mF = PVector.fromAngle(aVel + (HALF_PI));
    mF.setMag(xReduced);
    return mF;
  }
  
  PVector forceGrav() {
    return new PVector(0, g);
  }
  
  void update(PVector mPos) {
    update(mPos, 1);
  }
  
  void update(PVector mPos, float dt) {
    PVector mouseF = forceMouse(mPos.x);
    PVector gF = forceGrav();
    PVector dragF = forceDrag(); 
    force.mult(0);
    force.add(mouseF);
    force.add(gF);
    force.add(dragF);

    velocity.add(force.copy().mult(dt));

    pos.add(velocity.copy().mult(dt));
    println("V: " + velocity);
  }
  
  BoundingRect getBoundingRect() {
    return new BoundingRect(pos.x, pos.y, size, size);
  }
}