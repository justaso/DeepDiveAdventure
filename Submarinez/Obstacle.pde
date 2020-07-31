abstract class Obstacle {
  
  protected float x, y;
  protected float obWidth, obHeight, speedX, speedY;
  
  public Obstacle(float speedX, float speedY) {
    this.y = height;
    this.x = random(obWidth, width-obWidth);
    this.obWidth = width/10;
    this.obHeight = height/17;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  
  public Obstacle(float speedY) {
    this.speedY = speedY;
    this.obWidth = width/10;
    this.obHeight = height/17;
    y = height;
    x = random(obWidth, width-obWidth);
  }
  
  protected void move() {
    y -= speedY;
    if (y < 0) {
      y = height;
      x = random(obWidth, width-obWidth);
    }
  }

  // calculate target X coordinate of player for obstacle to move towards
  protected float calculateTargetX(Submarine player) {
    float targetX = player.x - this.x;
    targetX *= 0.005;
    return targetX;
  }
  
  // calculate target Y coordinate of player for obstacle to move towards
  protected float calculateTargetY(Submarine player) {
    float targetY = player.y - this.y;
    targetY *= 0.0001;
    return targetY;
  }
  
  public float getObWidth() {
    return obWidth;
  }
  
  public float getObHeight() {
    return obHeight;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public void setX(float x) {
    this.x = x;
  }
  
  public void setY(float y) {
    this.y = y;
  }
}
