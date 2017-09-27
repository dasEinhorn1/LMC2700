PVector dimensions = new PVector(800, 800);
boolean mDown;

float g = .01; // gravitational const.

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
  print('.');
  boarder.update(new PVector(mouseX, mouseY), mDown);
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