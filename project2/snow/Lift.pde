class Lift {
  PVector bottomPt;
  PVector topPt;
  float scale;
  
  PVector poleDim; 
  
  Lift(float _x1, float _y1, float _x2, float _y2) {
    this(_x1, _y1, _x2, _y2, 1);
  }
  
  Lift(float _x1, float _y1, float _x2, float _y2, float _scale) {
    bottomPt = new PVector(_x1, _y1);
    topPt = new PVector(_x2, _y2);
    scale = _scale;
    poleDim = new PVector(2 * scale, 20 * scale);
  }
  
  void draw() {
    float h = poleDim.y;
    float w = poleDim.x;
    float wheelR = 30 * scale / 2;
    float perspectiveMax = 3;
    PVector tWheel = new PVector(30 * scale / 2, 10 * scale / 2);
    
    // draw poles
    int numPoles = 1;
    fill(135,0,0);
    stroke(255,255,255);
    PVector currentPt = new PVector(topPt.x, topPt.y);
    for (int i = 0; i <= numPoles; i++) {
      currentPt.x = lerp(topPt.x, bottomPt.x, i / float(numPoles));
      currentPt.y = lerp(topPt.y, bottomPt.y, i / float(numPoles));
      println(currentPt);
      float scl = lerp (1, perspectiveMax, i / float(numPoles));
      strokeWeight(scl * poleDim.x);
      line(currentPt.x, currentPt.y, currentPt.x, currentPt.y - (h * scl));
      strokeWeight(scl);
      ellipse(currentPt.x, currentPt.y - (h * scl), tWheel.x * 2 * scl, tWheel.y * scl);
    }
    
    // connect wires
    strokeWeight(0);
    fill(255);
    triangle(topPt.x + tWheel.x, topPt.y - h, bottomPt.x + (tWheel.x * 3), bottomPt.y - 3 - (h * 3), bottomPt.x + (tWheel.x * 3), bottomPt.y + 3 - (h * 3));
    triangle(topPt.x - tWheel.x, topPt.y - h, bottomPt.x - (tWheel.x * 3), bottomPt.y - 3 - (h * 3), bottomPt.x - (tWheel.x * 3), bottomPt.y + 3 - (h * 3));
    line(topPt.x - tWheel.x, topPt.y - h, bottomPt.x - (tWheel.x * 3), bottomPt.y - (h * 3));
    
  }
}