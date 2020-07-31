class Boat extends Obstacle {
  private PImage boat1;
  
  public Boat(float speedY) {
    super(speedY);
    boat1 = loadImage("img/obstacles/boat.png");
  }
  
  private void render() {
    image(boat1, x, y, obWidth, obHeight);
  }
  
  public void update() {
    move();
    render();
  }
}
