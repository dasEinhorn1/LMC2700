/*
 *    I am from New Hampshire, so I spent the vast majority of my life braving the cold just biding my time
 * until it finally got warm enough to wear shorts. (I also have a summer birthday, so that definitely played a 
 * role in my eagerness to be warm again.) That said, there was one thing about the winter that my friends and I
 * all loved: sledding. When I was sledding, I was a trailblazer, literally carving my way through the snow,
 * finding creative (sometimes dangerous) paths down the hill, all so I could just run right back up to try
 * it again. By the end of the day, if it hadn't been snowing too hard, we could always look back on the trails  
 * we left on the hillsides.
 *  
 *
 *    For this project, I attempted to model that experience of 'drawing' trails in the snow during a long afternoon of sledding.
 * I modeled the physics of a sled going downhill, including drag, turning, and (of course) gravity, and added snow to slowly fade
 * any trails not consistently packed down by the sled. I also added trees, one of the many dangerous obstacles I faced when sledding
 * in my backyard. (You can make the hill more dangerous using "Somebody get Mom" mode). The 'drawing' in this case is unconventional,
 * and at times, even frustrating. Sometimes, the sled won't react as quickly as you'd hoped, other times it will react too quickly,
 * creating a trail which you didn't necessarily intend to create. You can never backtrack, and you can never erase. You can only go
 * forwards, or just short of horizontal. When you make a mistake in this form of drawing, only a blizzard can really fix it.
 * 
 *    When people typically think of a 'drawing tool' they often picture something which allows for deliberate, precise work. They don't
 * think of the potential for drawing media which actively derails precise, deliberate motions. With a sled, drawing is far more passive
 * the outcome, often accidental. The beauty of the sled as media is that it encourages acceptance of life's unpredictability.
 *
 * DIRECTIONS-
 *   Click to start sledding down the hill
 *   Move the mouse to the left or right to turn the sled (you don't need to hold down the mouse though)
 *   
 *   If you hit a tree, or go off the edge of the hill, you will restart from the top of the hill with your trails intact.
 *
 *   To add trees, change the snowfall, put trees onto the main path, or reset the sketch, use the options popup window.
 *   Each time you change the settings, you will need to reset the drawing. If you don't like where your trees ended up,
 *   just keep resetting until you do!
 */
import g4p_controls.*;
import java.util.LinkedList;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.Point;
import java.awt.MouseInfo;
import java.util.Collections;
import java.util.Comparator;

int SNOW_RATE = 200;
int NUM_TREES = 50;

boolean GET_MOM_MODE = false;

float FADE_RATE = 10.0/SNOW_RATE;

int windowX, windowY, absMouseX, absMouseY;

PVector dimensions = new PVector(800, 800);

int X_INPUT_MARGIN = 10;

boolean mDown = false; // whether the mouse is down

boolean started = false; // whether the sled should be starting down the hill;

boolean DEBUG = false; // shows bounding boxes and stuff

float M_FORCE = .2;
float DRAG = 0.05;
float g = .2; // gravitational const.

SnowEffect sEff;
Slope s;
Sled sled;
Path path;

void setup() {
  createGUI();
  surface.setSize(int(dimensions.x), int(dimensions.y));
  totalReset();
}

void totalReset() {
  sEff = new SnowEffect();
  frameRate(30);
  s = new Slope();
  sled = new Sled(width / 2, 205);
  FADE_RATE = SNOW_RATE/ 1000.0;
  noCursor();
}

void update() {
  s.updatePaths();
  if (!started) {
    return;
  }
  PVector mousePos = new PVector(mouseX, mouseY);
  sled.update(mousePos);
  s.update(sled, sled.angle());
  if (s.collisionDetected) {
    debugPrintln("RESET");
    climbBackUp();
    started = false;
  }

  MouseInfo.getPointerInfo();
  Point pt = MouseInfo.getPointerInfo().getLocation();
  absMouseX = (int)pt.getX();
  absMouseY = (int)pt.getY();
  if(mouseX > 50 && mouseX < width - 50 && mouseY > 50 && mouseY < height-50
                  && abs(mouseX - pmouseX) == 0 && abs(mouseY - pmouseY) == 0) {
    windowX = (int)(absMouseX - mouseX);
    windowY = (int)(absMouseY - mouseY);
  }
  int x = -1, y = -1;
  if(absMouseX < windowX) {
    x = windowX;
  } else if(absMouseX > windowX + width) {
    x = windowX + width;
  }
  if(absMouseY < windowY) {
    y = windowY;
  } else if(absMouseY > windowY + height) {
    y = windowY + height;
  }
  if(!(x == -1 && y == -1)) {
    try {
      Robot bot = new Robot();
      bot.mouseMove(x == -1 ? absMouseX : x, y == -1 ? absMouseY : y);
    } catch (AWTException e) {}
  }
    
}

void draw() {
  color c2 = color(32, 94, 165);
  background(c2);
  update();
  s.draw();
  sled.draw();
  s.drawTrees();
  sEff.draw();
}

void climbBackUp() {
  s.collisionDetected = false;
  sled = new Sled(width / 2, 205);
  
  started = false;
}

float scaleFromY(float y) {
  return map(y, 0, height, .5, 4);
}

void debugPrintln(Object o) {
  if (DEBUG) println(o);
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