import java.util.LinkedList;
PVector dimensions = new PVector(800, 800);

boolean mDown = false; // whether the mouse is down

boolean started = false; // whether the sled should be starting down the hill;

boolean DEBUG = false; // shows bounding boxes and stuff

float M_FORCE = .2;
float DRAG = 0.07;
float g = .2; // gravitational const.

Slope s;
Sled sled;
Path path;

void setup() {
  //size(int(dimensions.x), int(dimensions.y));
  size(800,800);
  s = new Slope(50);
  sled = new Sled(width / 2, 205);
  noCursor();
}

void update() {
  if (!started) {
      return;
  }
  PVector mousePos = new PVector(mouseX, mouseY);
  sled.update(mousePos);
  s.update(sled, sled.angle());
  if (s.collisionDetected) {
    reset();
    started = false;
  }
}

void draw() {
  //Point mouse;
  //mouse = MouseInfo.getPointerInfo().getLocation();
  //println( "X=" + mouse.x + " Y=" + mouse.y );
  //println("FRAME: (" + frame.getX()+ ", " + frame.getY() + ")");
  background(172, 198, 224);
  update();
  s.draw();
  sled.draw();
  s.drawTrees();
}

void reset() {
  s.collisionDetected = false;
  sled = new Sled(width / 2, 205);
  started = false;
}

void mousePressed() {
  mDown = true;
  if (!started) {
    started = true;
  }
}
void mouseReleased() {
  mDown = false;
}