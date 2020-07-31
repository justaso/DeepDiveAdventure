class Narwhal extends Obstacle {
  private PImage nar1, nar2, nar3;
  private int counter; // used for image animation
  
  public Narwhal(float speedY) {
    super(speedY);
    this.speedX = 1;
    this.obHeight = height/14;
    nar1 = loadImage("img/obstacles/nar1.png");
    nar2 = loadImage("img/obstacles/nar2.png");
    nar3 = loadImage("img/obstacles/nar3.png");
  }
  
  public void move(float x, float y) { // cannot use 'private' - unable to reduce visibility of inherited method
    super.move();
    this.x += x;
    this.y += y;
  }
  
  private void render() {
    if (counter >= 0 && counter <= 20) {
      image(nar1, x, y, obWidth, obHeight);
    } else if (counter > 20 && counter <= 40) {
      image(nar2, x, y, obWidth, obHeight);
    }  else if (counter > 40 && counter <= 60) {
      image(nar3, x, y, obWidth, obHeight);
    } else {
      image(nar1, x, y, obWidth, obHeight);
      counter = 0;
    }
    counter += 1;
  }
  
  public void update(float x, float y) {
    move(x, y);
    render();
  }
  
  // calculate target X coordinate of player for obstacle to move towards
  public float calculateTargetX(Submarine player) {
    float targetX = super.calculateTargetX(player);
    return targetX;
  }
  
  // calculate target Y coordinate of player for obstacle to move towards
  public float calculateTargetY(Submarine player) {
    float targetY = super.calculateTargetY(player);
    return targetY;
  }
}
