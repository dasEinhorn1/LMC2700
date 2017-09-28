PVector dimensions = new PVector(800, 800);
boolean mDown;
float M_FORCE = .2;
float DRAG = 0.07;
float g = .2; // gravitational const.

Slope s;
Snowboarder boarder;
//Lift lift;

Path path;

void setup() {
  //size(int(dimensions.x), int(dimensions.y));
  size(800,800);
  s = new Slope(50);
  boarder = new Snowboarder(width / 2, 200);
}

void update() {
  print('.');
  PVector mousePos = new PVector(mouseX, mouseY);
  boarder.update(mousePos);
  s.update(boarder.pos, boarder.angle());
  println("ON Slope? " + s.onSlope(boarder.pos));
}

void draw() {
  if (!s.onSlope(boarder.pos)) {
    reset();
  }
  background(172, 198, 224);
  update();
  s.draw();
  boarder.draw();
  s.drawTrees();
}

void reset() {
  boarder = new Snowboarder(width / 2, 200);
}

void mousePressed() {
  mDown = true;
}
void mouseReleased() {
  mDown = false;
}