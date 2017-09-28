class Snowboarder {
  PVector pos;
  float startH;
  float angle; // where the boarder is headed angle-wise
  PVector velocity;
  PVector force; // force on the border (angle, r)
  float size; 
  
  Snowboarder(float x, float y) {
    pos = new PVector(x, y);
    startH = y;
    velocity = new PVector(0, 0.00001);
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
  
  PVector forceDrag() {
    float aVel = velocity.heading();
    float magV = velocity.mag();
    //println("IDEAL: " + vi);
    //vi.x *= 0;
    //vi.y *= vi.y;
    float newMag = pow(magV, 2) * DRAG;
    PVector dragF = PVector.fromAngle(aVel + PI);
    dragF.mult(newMag);
    //println("DRAG: " + dragF);
    return dragF;
  }
  
  //float getAngleFromMouse(float mX) {
  //  float xRel = mX - width/2; // mouse relative to the boarder
  //  println("TURN", xRel);
  //  int qd = (abs(xRel) == xRel) ? 1 : 0; // 1 if mouse is to the left
  //  float a = map(xRel, -width/2, width/2, PI *( 0.5f + qd), PI * (1.5 + qd));
  //  a += PI;
  //  println(a/PI + "pi");
  //  return a;
  //}
   
  PVector forceMouse(float mX) {
    float xRel = mX - width/2; // relative to center
    float xReduced = map(xRel, -width/2, width/2, M_FORCE, -M_FORCE);
    println(xReduced);
    // int dir = (abs(xRel) == xRel) ? 1 : -1; // 1 if mouse is to the left
    float aVel = velocity.heading();
    PVector mF = PVector.fromAngle(aVel + (PI/ 2));
    mF.setMag(xReduced);
    return mF;
  }
  
  PVector forceGrav() {
    return new PVector(0, g);
  }
  
  void update(PVector mPos, float dt) {
    // get an angle relative to mouse.x between pi/2 and 3pi/2 
    PVector mouseF = forceMouse(mPos.x);
    PVector gF = forceGrav();
    PVector dragF = forceDrag(); 
    //force.x = map(mPos.x - pos.x, -width, width, -1, 1);
    //force.y = 1 - map(mPos.y, 0, height, -1.0, 1.0f);
    //if (slowing && force.y > .01) {
    //  force.y = -0.1;
    //} else if (!slowing && force.y < .1) {
    //  force.y = 0.1;
    //}
    //force.limit(1);
    force.mult(0);
    force.add(mouseF);
    force.add(gF);
    force.add(dragF);

    velocity.add(force.copy().mult(dt));

    pos.add(velocity.copy().mult(dt));
    println("V: " + velocity);
  }
}