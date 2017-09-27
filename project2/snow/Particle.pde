public class Particle {
  PVector pos, vel, acc;        //this line declares variables pos, vel, and acc (short for position, velocity, and 
                                //acceleration)
  color col;
  float maxVel;
  int size;
  boolean dead;
  
  public Particle(float _x, float _y, float _vX, float _vY, int _size, float _mV, color _col) {
    pos = new PVector(_x, _y);  //this instantiates a new PVector object (a Processing Vector) with two components 
                                //(x and y). we'll use this to keep the position of the particle
                                //PVectors are essentially 3 floats smooshed together, but with some helpful built 
                                //in functions
    vel = new PVector(_vX, _vY);
    acc = new PVector(0, 0);
    maxVel = _mV;
    size = _size;
    col = _col;           
  }
  
  /*
  This is the draw function of the particle, this is what we'll call to have the particle do its thing and display
  */
  void draw() {                      //I like to separate the movement stuff and drawing stuff
    update();
    noStroke();                        //removes lines around objects
    fill(col);                         //sets current fill color for objects, any objects made after this call will be
                                       // be the same color
    ellipse(pos.x, pos.y, size, size); //ellipse draws an ellipse (an oval thing) at position pos.x, pos.y with major
                                       //axis size and minor axis size (so a circle)
  }
  
  void update() {
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    //println(pos, vel, acc);
    acc.set(0,0);
    //if (pos.x < -bound || pos.x > width + bound || pos.y < -bound || pos.y > height + bound)
      dead = true;
  }
  
  void addForce(PVector force) {
    acc.add(force);
  }
}