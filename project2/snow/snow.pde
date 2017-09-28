PVector dimensions = new PVector(800, 800);
boolean mDown;
float M_FORCE = .1;
float DRAG = 0.05;
float g = .1; // gravitational const.

//Slope s;
Snowboarder boarder;
//Tree[] trees;
//Lift lift;

//Path path;

void setup() {
  //size(int(dimensions.x), int(dimensions.y));
  size(800,800);
  
  boarder = new Snowboarder(100, 200);
  background(0);
}

void update() {
  //frames - frameCount;
  print('.');
  boarder.update(new PVector(mouseX, mouseY), 1);
}

void draw() {
  update();
  boarder.draw();
}

void mousePressed() {
  mDown = true;
}
void mouseReleased() {
  mDown = false;
}