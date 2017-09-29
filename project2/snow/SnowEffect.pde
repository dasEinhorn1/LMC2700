color snowColor = color(219, 234, 249);
class SnowEffect {
  int quantity;
  float [] xPosition;
  float [] yPosition;
  int [] flakeSize;
  int [] direction;
  int minFlakeSize = 1;
  int maxFlakeSize = 5;
  
  SnowEffect() {
    this(SNOW_RATE);
  }
  
  SnowEffect(int quantity) {
    this.quantity = quantity;
    xPosition = new float[quantity];
    yPosition = new float[quantity];
    flakeSize = new int[quantity];
    direction = new int[quantity];
    for(int i = 0; i < quantity; i++) {
      flakeSize[i] = round(random(minFlakeSize, maxFlakeSize));
      xPosition[i] = random(0, width);
      yPosition[i] = random(0, height);
      direction[i] = round(random(0, 1));
    }
    
  }
  
  void draw() {
    fill(snowColor);
    for(int i = 0; i < xPosition.length; i++) {
      ellipse(xPosition[i], yPosition[i], flakeSize[i], flakeSize[i]);
      if(direction[i] == 0) {
        xPosition[i] += map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
      } else {
        xPosition[i] -= map(flakeSize[i], minFlakeSize, maxFlakeSize, .1, .5);
      }
      yPosition[i] += flakeSize[i] + direction[i]; 
      if(xPosition[i] > width + flakeSize[i] || xPosition[i] < -flakeSize[i] || yPosition[i] > height + flakeSize[i]) {
        xPosition[i] = random(0, width);
        yPosition[i] = -flakeSize[i];
      } 
    }
  }
}