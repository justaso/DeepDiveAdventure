class HealthPoints extends Obstacle {
  
  private PImage boom1, boom2, boom3, boom4;
  private int counter; // used for image animation
  
  public HealthPoints (float speedY) {
    super(speedY);
    boom1 = loadImage("img/obstacles/boom1.png");
    boom2 = loadImage("img/obstacles/boom2.png");
    boom3 = loadImage("img/obstacles/boom3.png");
    boom4 = loadImage("img/obstacles/boom4.png");
  }
  
  private void render() {
    if (counter >= 0 && counter <= 15) {
      image(boom1, x, y, obWidth, obHeight);
    } else if (counter > 15 && counter <= 30) {
      image(boom2, x, y, obWidth, obHeight);
    }  else if (counter > 30 && counter <= 45) {
      image(boom3, x, y, obWidth, obHeight);
    } else if (counter > 45 && counter <= 60) {
      image(boom4, x, y, obWidth, obHeight);
    } else {
      image(boom1, x, y, obWidth, obHeight);
      counter = 0;
    }
    counter += 1;
  }
  
  public void update() {
    move();
    render();
  }
}
