class Medusa extends Obstacle {
  private PImage med1, med2;
  private int counter; // used for image animation
  
  public Medusa(float speedX, float speedY) {
    super(speedX, speedY);
    med1 = loadImage("img/obstacles/med1.png");
    med2 = loadImage("img/obstacles/med2.png");
  }
  
  public void move() { // cannot use 'private' - unable to reduce visibility of inherited method
    super.move();
    x -= speedX;
    if (x < 0 || x > width-obWidth) {
      speedX = -speedX;
    }
  }
  
  private void render() {
    if (counter >= 0 && counter <= 30) {
      image(med1, x, y, obWidth, obHeight);
    } else if (counter > 30 && counter <= 60) {
      image(med2, x, y, obWidth, obHeight);
    }  else {
      image(med1, x, y, obWidth, obHeight);
      counter = 0;
    }
    
    counter += 1;
  }
  
  public void update() {
    move();
    render();
  }
    
    
}
