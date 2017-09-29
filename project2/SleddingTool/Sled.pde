color[] sweaterColors = {color(178, 79, 255), color(27, 78, 150), color(33, 165, 123)};
class Sled {
  PVector pos;
  float startH;
  PVector velocity;
  PVector force; // force on the border (angle, r)
  float size; 
  color sweaterColor;
  color hatColor;
  float scl;
  Sled(float x, float y) {
    this(x, y, 10);
  }
  
  Sled(float x, float y, float sz) {
    pos = new PVector(x, y);
    startH = y;
    velocity = new PVector(0, 0.00001);
    force = new PVector(3 * PI / 2, g);
    size = sz;
    sweaterColor = sweaterColors[int(random(sweaterColors.length))];
    hatColor = sweaterColors[int(random(sweaterColors.length))];
    scl = scaleFromY(y);
  }
  
  void draw() {
    strokeWeight(1);
    fill(255, 110, 81);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(velocity.heading() - HALF_PI);
    // sled base
    rect(-(rSize()-5)/2, -(rSize())/2, rSize()-5, rSize());
    // jacket
    fill(sweaterColor);
    arc(0, rSize()/8, 0.5 * rSize(), 0.75 * rSize(), -PI, 0, PIE);
    //front thing
    fill(255, 110, 81);
    arc(0, rSize()/2, rSize()-5, rSize(), -PI, 0, PIE);
    //head
    fill(255, 219, 175);
    ellipse(0, -rSize()/2 + rSize()/8, 0.5 * rSize(), 0.5 * rSize());
    //hat
    fill(hatColor);
    arc(0, -rSize()/2 + rSize()/8, 0.5 * rSize(), 0.5 * rSize(), -PI, 0, PIE);
    popMatrix();
    
    if (DEBUG) {
      getBoundingRect().draw();
    }
    
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
    float xReduced;
    if (abs(xRel) > width/2 - X_INPUT_MARGIN) {
      xReduced = M_FORCE * xRel/abs(xRel);
    }
    xReduced = map(xRel, X_INPUT_MARGIN -(width/2), (width/2) - X_INPUT_MARGIN, M_FORCE, -M_FORCE);
    debugPrintln(xReduced);
    // int dir = (abs(xRel) == xRel) ? 1 : -1; // 1 if mouse is to the left
    float aVel = velocity.heading();
    debugPrintln("VEL ANGLE: " + aVel);
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
    scl = scaleFromY(pos.y);
  }
  
  float rSize() { // size with y scale
    return size * scl;
  }
  
  BoundingRect getBoundingRect() {
    return new BoundingRect(pos.x - rSize() / 2, pos.y-rSize()/2, rSize(), rSize());
  }
}